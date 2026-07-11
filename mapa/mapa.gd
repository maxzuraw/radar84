extends Control

@onready var radar_map = $RadarMap

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
