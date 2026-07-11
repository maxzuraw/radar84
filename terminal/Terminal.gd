extends Control

@onready var system: Node2D = $TerminalSystem
@onready var command_input: LineEdit = $VBoxContainer/HBoxContainer/CommandInput
@onready var key_sound: AudioStreamPlayer2D = $VBoxContainer/HBoxContainer/AudioStreamPlayer2D
@onready var terminal_output: RichTextLabel = $VBoxContainer/TerminalOutput

var command_history: Array[String] = []
var history_index: int = 0

func _ready() -> void:
	command_input.text_submitted.connect(_on_command_submitted)
	command_input.grab_focus()
	print_response(system.init_message())

func _on_command_submitted(command: String) -> void:
	var cleaned_command := command.strip_edges()
	if cleaned_command.is_empty():
		return
	print_response(system.print_command(command))
	command_history.append(cleaned_command)
	history_index = command_history.size()
	command_input.clear()
	print_response(system.execute(cleaned_command))
	command_input.grab_focus()
	_symuluj_wcisniecie_enter()

func scroll_to_bottom() -> void:
	await get_tree().process_frame
	terminal_output.scroll_to_line(terminal_output.get_line_count() - 1)

func print_response(message: String) -> void:
	terminal_output.append_text(message)
	scroll_to_bottom()

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

func _on_terminal_system_clear_screen() -> void:
	terminal_output.clear()

func _symuluj_wcisniecie_enter():
	var enter_event := InputEventKey.new()
	enter_event.keycode = KEY_ENTER
	enter_event.pressed = true
	Input.parse_input_event(enter_event)
