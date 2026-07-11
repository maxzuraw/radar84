extends Control

@export var sweep_period: float = 10.0

## Środek zielonego pola radaru względem rozmiaru kontrolki.
@export var radar_center_normalized := Vector2(0.5, 0.488)

## Promienie zielonej elipsy względem rozmiaru kontrolki.
@export var radar_radius_normalized := Vector2(0.40, 0.470)

@export var sector_padding: float = 15.0
@export var blip_radius: float = 5.0
@export var blip_fade_time: float = 10.0

@export var sweep_color := Color(0.35, 1.0, 0.35, 0.85)
@export var blip_color := Color(0.65, 1.0, 0.65, 1.0)

@export var trail_duration: float = 0.7
@export var trail_sample_interval: float = 0.03

@export var trail_inner_width: float = 8.0
@export var trail_outer_width: float = 16.0

@export var trail_inner_alpha: float = 0.10
@export var trail_outer_alpha: float = 0.05

@export var trail_color := Color(0.45, 1.0, 0.45, 1.0)

var sweep_trail: Array = []
var trail_sample_accumulator: float = 0.0

var sweep_angle: float = 0.0
var previous_sweep_angle: float = 0.0

var target_radar_position: Vector2
var has_target := false

var detected_radar_position: Vector2
var has_detected_blip := false
var blip_age: float = 0.0


func _ready() -> void:
	set_anchors_and_offsets_preset(
		Control.PRESET_FULL_RECT
	)
	resized.connect(_on_resized)
	queue_redraw()


func _process(delta: float) -> void:
	if sweep_period <= 0.0:
		return

	previous_sweep_angle = sweep_angle

	var angular_speed := TAU / sweep_period
	sweep_angle = fposmod(
		sweep_angle + angular_speed * delta,
		TAU
	)

	_update_sweep_trail(delta)

	if has_detected_blip:
		blip_age += delta

	if has_target:
		_check_target_hit()

	queue_redraw()


func _draw() -> void:
	_draw_sweep_trail()
	_draw_sweep_line()
	_draw_blip()


func _on_resized() -> void:
	queue_redraw()


func get_radar_center() -> Vector2:
	return Vector2(
		size.x * radar_center_normalized.x,
		size.y * radar_center_normalized.y
	)


func get_radar_radius() -> Vector2:
	return Vector2(
		size.x * radar_radius_normalized.x,
		size.y * radar_radius_normalized.y
	)


func _draw_sweep_line() -> void:
	var center := get_radar_center()
	var radius := get_radar_radius()

	var direction := Vector2(
		cos(sweep_angle),
		sin(sweep_angle)
	)

	var line_length := _get_ellipse_edge_distance(
		direction,
		radius
	)

	var line_end := center + direction * line_length

	draw_line(
		center,
		line_end,
		sweep_color,
		2.0,
		true
	)


func _draw_blip() -> void:
	if not has_detected_blip:
		return

	var alpha = 1.0 - clamp(
		blip_age / blip_fade_time,
		0.0,
		1.0
	)

	if alpha <= 0.0:
		return

	var color := blip_color
	color.a *= alpha

	draw_circle(
		detected_radar_position,
		blip_radius,
		color
	)


func set_target_sector(sector_name: String) -> void:
	var parsed_position = _sector_to_radar_position(
		sector_name
	)

	if parsed_position == null:
		push_warning(
			"Niepoprawny sektor radaru: " + sector_name
		)
		return

	target_radar_position = parsed_position
	has_target = true


func _sector_to_radar_position(
	sector_name: String
) -> Variant:
	var normalized := sector_name.strip_edges().to_upper()
	var parts := normalized.split("-")

	if parts.size() != 2:
		return null

	var column_text := parts[0]
	var row_text := parts[1]

	if column_text.length() != 1:
		return null

	if not row_text.is_valid_int():
		return null

	var column_index := (
		column_text.unicode_at(0)
		- "A".unicode_at(0)
	)

	var row_number := row_text.to_int()

	if column_index < 0 or column_index > 18:
		return null

	if row_number < 1 or row_number > 18:
		return null

	## I ma indeks 8.
	var center_column := 8

	## Środkowy wiersz to 9.
	var center_row := 9

	var column_offset := column_index - center_column
	var row_offset := row_number - center_row

	var center := get_radar_center()
	var radius := get_radar_radius()

	var usable_radius_x := radius.x - sector_padding
	var usable_radius_y := radius.y - sector_padding

	## Od I do S jest 10 kroków.
	var right_step_x := usable_radius_x / 10.0

	## Od I do A jest 8 kroków.
	var left_step_x := usable_radius_x / 8.0

	## Od 9 do 18 jest 9 kroków.
	var bottom_step_y := usable_radius_y / 9.0

	## Od 9 do 1 jest 8 kroków.
	var top_step_y := usable_radius_y / 8.0

	var offset_x: float

	if column_offset >= 0:
		offset_x = column_offset * right_step_x
	else:
		offset_x = column_offset * left_step_x

	var offset_y: float

	if row_offset >= 0:
		offset_y = row_offset * bottom_step_y
	else:
		offset_y = row_offset * top_step_y

	return center + Vector2(offset_x, offset_y)


func _check_target_hit() -> void:
	var center := get_radar_center()
	var target_vector := target_radar_position - center

	## Sektor I-9 leży dokładnie w środku.
	if target_vector.length_squared() < 0.01:
		if sweep_angle < previous_sweep_angle:
			_register_hit()

		return

	var target_angle := fposmod(
		target_vector.angle(),
		TAU
	)

	if _angle_was_crossed(
		previous_sweep_angle,
		sweep_angle,
		target_angle
	):
		_register_hit()


func _angle_was_crossed(
	from_angle: float,
	to_angle: float,
	target_angle: float
) -> bool:
	var travelled := fposmod(
		to_angle - from_angle,
		TAU
	)

	var target_distance := fposmod(
		target_angle - from_angle,
		TAU
	)

	return target_distance <= travelled


func _register_hit() -> void:
	detected_radar_position = target_radar_position
	has_detected_blip = true
	blip_age = 0.0


func _get_ellipse_edge_distance(
	direction: Vector2,
	radius: Vector2
) -> float:
	var x_part := direction.x / radius.x
	var y_part := direction.y / radius.y

	var denominator := sqrt(
		x_part * x_part
		+ y_part * y_part
	)

	if denominator <= 0.0001:
		return 0.0

	return 1.0 / denominator

func _update_sweep_trail(delta: float) -> void:
	trail_sample_accumulator += delta

	while trail_sample_accumulator >= trail_sample_interval:
		trail_sample_accumulator -= trail_sample_interval

		sweep_trail.append({
			"angle": sweep_angle,
			"age": 0.0
		})

	for i in range(sweep_trail.size() - 1, -1, -1):
		var sample = sweep_trail[i]
		sample["age"] += delta

		if sample["age"] > trail_duration:
			sweep_trail.remove_at(i)
		else:
			sweep_trail[i] = sample

func _draw_sweep_trail() -> void:
	if sweep_trail.is_empty():
		return

	var center := get_radar_center()
	var radius := get_radar_radius()

	for sample in sweep_trail:
		var age: float = sample["age"]
		var angle: float = sample["angle"]

		var life = 1.0 - clamp(age / trail_duration, 0.0, 1.0)
		if life <= 0.0:
			continue

		var direction := Vector2(cos(angle), sin(angle))
		var line_length := _get_ellipse_edge_distance(direction, radius)
		var line_end := center + direction * line_length

		# Zewnętrzna, bardzo delikatna poświata
		var outer_color := trail_color
		outer_color.a = trail_outer_alpha * life

		draw_line(
			center,
			line_end,
			outer_color,
			trail_outer_width * life + 1.0,
			true
		)

		# Wewnętrzna, trochę mocniejsza poświata
		var inner_color := trail_color
		inner_color.a = trail_inner_alpha * life

		draw_line(
			center,
			line_end,
			inner_color,
			trail_inner_width * life + 1.0,
			true
		)
