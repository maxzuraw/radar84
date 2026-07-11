extends Control

@onready var terminal: Control = $Terminal
@onready var radar: Control = $Radar
@onready var window: Control = $Window
@onready var mapa: Control = $Mapa

func _ready() -> void:
	show_view(terminal)


func show_view(selected_view: Control) -> void:
	terminal.hide()
	radar.hide()
	window.hide()
	mapa.hide()
	
	selected_view.show()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_terminal_button_pressed() -> void:
	show_view(terminal)


func _on_radar_button_pressed() -> void:
	show_view(radar)


func _on_window_button_pressed() -> void:
	show_view(window)


func _on_map_button_pressed() -> void:
	show_view(mapa)
