extends Node2D

@onready var mapa = $SceneControl/Mapa
@onready var radar_overlay: Control = $SceneControl/Radar/RadarOverlay


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mapa.sector_changed.connect(_on_moving_point_sector_changed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_moving_point_sector_changed(sector_name: String) -> void:
	radar_overlay.set_target_sector(sector_name)
