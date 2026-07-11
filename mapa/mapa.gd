extends Control

@onready var radar_map = $RadarMap
signal sector_changed(sector_name: String)
signal position_changed(map_position: Vector2)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	radar_map.sector_changed.connect(
		_on_radar_sector_changed
	)

	radar_map.path_finished.connect(
		_on_radar_path_finished
	)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_radar_sector_changed(sector_name: String) -> void:
	print(
		"SYGNAŁ: obiekt znajduje się w sektorze ",
		sector_name
	)

	# Przykład:
	# $Terminal.add_output(
	#     "SIGNAL POSITION: " + sector_name
	# )

func _on_radar_path_finished() -> void:
	print("Obiekt zakończył trasę.")


func _on_radar_map_position_changed(map_position: Vector2) -> void:
	position_changed.emit(map_position)


func _on_radar_map_sector_changed(sector_name: String) -> void:
	sector_changed.emit(sector_name)
