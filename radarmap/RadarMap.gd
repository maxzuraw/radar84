extends Node2D

signal sector_changed(sector_name: String)
signal position_changed(map_position: Vector2)
signal path_started
signal path_finished

const COLUMN_NAMES: Array[String] = [
	"A", "B", "C", "D", "E", "F",
	"G", "H", "I", "J", "K", "L",
	"M", "N", "O", "P", "R", "S"
]

const COLUMNS: int = 18
const ROWS: int = 18

const GRID_ORIGIN := Vector2(40.0, 33.0)
const SECTOR_SIZE := Vector2(40.0, 32.0)
const GRID_SIZE := Vector2(720.0, 576.0)

@export_category("Ruch obiektu")
@export var point_speed: float = 60.0

@export_range(2, 30, 1)
var path_sector_count: int = 8

@export_range(1, 10, 1)
var minimum_sector_distance: int = 2

@export var start_automatically: bool = true

@export_category("Kształt ścieżki")

## Gdy true, każdy kolejny punkt będzie znajdował się bardziej
## na prawo niż poprzedni. Daje to bardziej logiczny przelot.
@export var move_from_left_to_right: bool = true

## Czy pierwszy punkt ma znajdować się w pierwszej kolumnie.
@export var start_at_left_edge: bool = true

## Czy ostatni punkt ma znajdować się w ostatniej kolumnie.
@export var end_at_right_edge: bool = true

@export_category("Debug")

## Pokazuje wygenerowaną ścieżkę.
@export var show_debug_path: bool = false

## Pokazuje poruszający się punkt.
@export var show_debug_point: bool = false

## Wypisuje zmianę sektora w konsoli.
@export var print_sector_changes: bool = true

@onready var sector_markers: Node2D = $SectorMarkers
@onready var hidden_path: Path2D = $HiddenPath
@onready var hidden_point: PathFollow2D = $HiddenPath/HiddenPoint
@onready var debug_path: Line2D = get_node_or_null("DebugPath")
@onready var debug_point: CanvasItem = get_node_or_null(
	"HiddenPath/HiddenPoint/DebugPoint"
)

var current_sector: String = ""
var path_length: float = 0.0
var scenario_running: bool = false

# Klucz: nazwa sektora, np. "A-11".
# Wartość: środek sektora jako Vector2.
var sector_positions: Dictionary = {}

# Lista sektorów, przez które prowadzą punkty kontrolne ścieżki.
var generated_path_sectors: Array[String] = []

func _ready() -> void:
	randomize()

	hidden_point.loop = false
	hidden_point.rotates = false

	_create_sector_markers()
	_update_debug_visibility()

	if start_automatically:
		start_random_scenario()


func _process(delta: float) -> void:
	if not scenario_running:
		return

	hidden_point.progress += point_speed * delta

	var point_position := hidden_point.position

	position_changed.emit(point_position)
	_check_current_sector(point_position)

	if hidden_point.progress >= path_length:
		_finish_scenario()

func _create_sector_markers() -> void:
	for child in sector_markers.get_children():
		child.queue_free()

	sector_positions.clear()

	for row_index in range(ROWS):
		for column_index in range(COLUMNS):
			var sector_name := get_sector_name(
				column_index,
				row_index
			)

			var marker := Marker2D.new()
			marker.name = sector_name
			marker.position = get_sector_center(
				column_index,
				row_index
			)

			marker.set_meta("sector_name", sector_name)
			marker.set_meta("column_index", column_index)
			marker.set_meta("row_index", row_index)

			sector_markers.add_child(marker)
			sector_positions[sector_name] = marker.position

func get_sector_name(
	column_index: int,
	row_index: int
) -> String:
	if column_index < 0 or column_index >= COLUMNS:
		return ""

	if row_index < 0 or row_index >= ROWS:
		return ""

	return "%s-%d" % [
		COLUMN_NAMES[column_index],
		row_index + 1
	]


func get_sector_center(
	column_index: int,
	row_index: int
) -> Vector2:
	return GRID_ORIGIN + Vector2(
		(column_index + 0.5) * SECTOR_SIZE.x,
		(row_index + 0.5) * SECTOR_SIZE.y
	)


func get_sector_position(sector_name: String) -> Vector2:
	if not sector_positions.has(sector_name):
		push_warning(
			"Nie istnieje sektor: %s" % sector_name
		)
		return Vector2.ZERO

	return sector_positions[sector_name]
	
func get_sector_at_position(local_position: Vector2) -> String:
	var position_inside_grid := local_position - GRID_ORIGIN

	if position_inside_grid.x < 0.0:
		return ""

	if position_inside_grid.y < 0.0:
		return ""

	if position_inside_grid.x >= GRID_SIZE.x:
		return ""

	if position_inside_grid.y >= GRID_SIZE.y:
		return ""

	var column_index := int(
		floor(position_inside_grid.x / SECTOR_SIZE.x)
	)

	var row_index := int(
		floor(position_inside_grid.y / SECTOR_SIZE.y)
	)

	return get_sector_name(column_index, row_index)


func _check_current_sector(point_position: Vector2) -> void:
	var detected_sector := get_sector_at_position(
		point_position
	)

	if detected_sector.is_empty():
		return

	if detected_sector == current_sector:
		return

	current_sector = detected_sector
	sector_changed.emit(current_sector)

	if print_sector_changes:
		print(
			"Obiekt znajduje się w sektorze: ",
			current_sector
		)

func start_random_scenario() -> void:
	stop_scenario()

	current_sector = ""
	generated_path_sectors.clear()

	_generate_random_path()

	path_length = hidden_path.curve.get_baked_length()

	if path_length <= 0.0:
		push_warning("Wygenerowana ścieżka jest pusta.")
		return

	hidden_point.progress = 0.0
	scenario_running = true

	_update_debug_path()
	_update_debug_visibility()

	# Natychmiast emituje sektor początkowy.
	_check_current_sector(hidden_point.position)

	path_started.emit()


func stop_scenario() -> void:
	scenario_running = false
	hidden_point.progress = 0.0


func restart_scenario() -> void:
	start_random_scenario()


func _finish_scenario() -> void:
	if not scenario_running:
		return

	scenario_running = false
	hidden_point.progress = path_length

	path_finished.emit()
	
func _generate_random_path() -> void:
	var curve := Curve2D.new()
	var selected_sectors := _generate_random_sector_sequence()

	for sector_coordinates in selected_sectors:
		var column_index: int = sector_coordinates.x
		var row_index: int = sector_coordinates.y

		var sector_name := get_sector_name(
			column_index,
			row_index
		)

		var sector_center := get_sector_center(
			column_index,
			row_index
		)

		curve.add_point(sector_center)
		generated_path_sectors.append(sector_name)

	hidden_path.curve = curve
	
func _generate_random_sector_sequence() -> Array[Vector2i]:
	var result: Array[Vector2i] = []

	var actual_point_count := clampi(
		path_sector_count,
		2,
		COLUMNS
	)

	if move_from_left_to_right:
		result = _generate_left_to_right_sequence(
			actual_point_count
		)
	else:
		result = _generate_fully_random_sequence(
			actual_point_count
		)

	return result
	
func _generate_left_to_right_sequence(point_count: int) -> Array[Vector2i]:
	var result: Array[Vector2i] = []
	var used_columns: Array[int] = []

	for point_index in range(point_count):
		var column_index: int

		if point_index == 0 and start_at_left_edge:
			column_index = 0

		elif (
			point_index == point_count - 1
			and end_at_right_edge
		):
			column_index = COLUMNS - 1

		else:
			# Rozkłada punkty mniej więcej równomiernie
			# pomiędzy początkiem i końcem mapy.
			var ratio := float(point_index) / float(
				point_count - 1
			)

			var expected_column := roundi(
				ratio * float(COLUMNS - 1)
			)

			var random_offset := randi_range(-1, 1)

			column_index = clampi(
				expected_column + random_offset,
				1,
				COLUMNS - 2
			)

			# Pilnuje, aby kolumny stale szły w prawo.
			if not used_columns.is_empty():
				column_index = maxi(
					column_index,
					used_columns[-1] + 1
				)

			# Zostaw miejsce na pozostałe punkty.
			var remaining_points := (
				point_count - point_index - 1
			)

			column_index = mini(
				column_index,
				COLUMNS - 1 - remaining_points
			)

		used_columns.append(column_index)

		var row_index := _get_random_row_for_next_point(
			result,
			column_index
		)

		result.append(
			Vector2i(column_index, row_index)
		)

	return result

func _get_random_row_for_next_point(existing_points: Array[Vector2i], column_index: int) -> int:
	if existing_points.is_empty():
		return randi_range(0, ROWS - 1)

	var previous_point := existing_points[-1]

	for attempt in range(30):
		var candidate_row := randi_range(0, ROWS - 1)

		var candidate := Vector2i(
			column_index,
			candidate_row
		)

		if _sector_distance(
			previous_point,
			candidate
		) >= minimum_sector_distance:
			return candidate_row

	# Awaryjnie wybiera dowolny wiersz.
	return randi_range(0, ROWS - 1)

func _sector_distance(first: Vector2i, second: Vector2i) -> float:
	return Vector2(first).distance_to(
		Vector2(second)
	)

func _generate_fully_random_sequence(point_count: int) -> Array[Vector2i]:
	var result: Array[Vector2i] = []

	while result.size() < point_count:
		var candidate := Vector2i(
			randi_range(0, COLUMNS - 1),
			randi_range(0, ROWS - 1)
		)

		if candidate in result:
			continue

		if not result.is_empty():
			var previous := result[-1]

			if _sector_distance(
				previous,
				candidate
			) < minimum_sector_distance:
				continue

		result.append(candidate)

	return result

func _update_debug_visibility() -> void:
	if debug_path != null:
		debug_path.visible = show_debug_path

	if debug_point != null:
		debug_point.visible = show_debug_point


func _update_debug_path() -> void:
	if debug_path == null:
		return

	debug_path.clear_points()
	debug_path.visible = show_debug_path

	if hidden_path.curve == null:
		return

	for point in hidden_path.curve.get_baked_points():
		debug_path.add_point(point)
