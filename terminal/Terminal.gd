extends Control

@onready var command_input: LineEdit = $VBoxContainer/HBoxContainer/CommandInput
@onready var key_sound: AudioStreamPlayer2D = $VBoxContainer/HBoxContainer/AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _unhandled_key_input(event: InputEvent) -> void:
	if not command_input.has_focus():
		return
		
	var ignored_keys := [
		KEY_SHIFT,
		KEY_CTRL,
		KEY_ALT,
		KEY_META,
		KEY_ESCAPE,
		KEY_CAPSLOCK,
		KEY_TAB,
		KEY_UP,
		KEY_DOWN,
		KEY_LEFT,
		KEY_RIGHT
	]
	var key_event := event as InputEventKey
	
	if key_event.keycode in ignored_keys:
		return
	
	key_sound.play()
