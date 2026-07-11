extends Control

@onready var command_input: LineEdit = $VBoxContainer/HBoxContainer/CommandInput
@onready var key_sound: AudioStreamPlayer2D = $VBoxContainer/HBoxContainer/AudioStreamPlayer2D
@onready var terminal_output: RichTextLabel = $VBoxContainer/TerminalOutput

var command_history: Array[String] = []
var history_index: int = 0

func _ready() -> void:
	command_input.text_submitted.connect(_on_command_submitted)
	command_input.grab_focus()
	
	print_system_message("RADAR-84 SYSTEM TERMINAL")
	print_system_message("Type HELP for available commands.")

func execute_command(command: String) -> void:
	var parts := command.split(" ", false)

	if parts.is_empty():
		return

	var command_name := parts[0].to_lower()
	var arguments := parts.slice(1)

	match command_name:
		"help":
			show_help()

		"clear", "cls":
			terminal_output.clear()

		"status":
			print_response("RADAR: ONLINE")
			print_response("SIGNAL: STABLE")
			print_response("SECTOR: 04")

		"scan":
			execute_scan(arguments)

		"ping":
			print_response("PONG")

		"echo":
			print_response(" ".join(arguments))

		"exit":
			print_response("Not enough rights to close the system.")

		_:
			print_error("Unknown command: %s" % command_name)
			print_response("Type HELP for available commands list.")

func execute_scan(arguments: Array[String]) -> void:
	if arguments.is_empty():
		print_error("Usage: SCAN <SEKTOR>")
		return

	var sector := arguments[0].to_upper()

	print_response("Rozpoczynam skan sektora %s..." % sector)

	match sector:
		"A1":
			print_response("Brak obiektów.")

		"B4":
			print_response("Wykryto słaby sygnał.")
			print_response("ODLEGŁOŚĆ: NIEZNANA")
			print_response("ROZMIAR: BŁĄD ODCZYTU")

		_:
			print_response("Sektor %s jest poza zasięgiem radaru." % sector)

func print_error(message: String) -> void:
	terminal_output.append_text(
		"[color=#ff7777]ERROR: %s[/color]\n" % escape_bbcode(message)
	)
	scroll_to_bottom()

func _on_command_submitted(command: String) -> void:
	var cleaned_command := command.strip_edges()
	
	if cleaned_command.is_empty():
		return

	print_command(command)
	
	command_history.append(cleaned_command)
	history_index = command_history.size()
	
	command_input.clear()
	
	execute_command(cleaned_command)
	

func print_system_message(message: String) -> void:
	terminal_output.append_text(
		"[color=#d5ffd5]%s[/color]\n" % escape_bbcode(message)
	)
	scroll_to_bottom()

func scroll_to_bottom() -> void:
	await get_tree().process_frame
	terminal_output.scroll_to_line(terminal_output.get_line_count() - 1)

func print_command(command: String) -> void:
	terminal_output.append_text(
		"[color=#a8ffa8]%s[/color]\n" % escape_bbcode(command)
	)	

func escape_bbcode(text: String) -> String:
	return text.replace("[", "[lb]").replace("]", "[rb]")

func show_help() -> void:
	print_response("AVAILABLE COMMANDS:")
	print_response("HELP\t\t\t\t\t- list of commands")
	print_response("STATUS\t\t\t\t- system status")
	print_response("SCAN <SEKTOR>\t- sector scanning")
	print_response("ECHO <TEKST>\t\t- print text")
	print_response("CLEAR\t\t\t\t- clear terminal")
	print_response("PING\t\t\t\t\t- communication test")

func print_response(message: String) -> void:
	terminal_output.append_text(
		"[color=#a8ffa8]%s[/color]\n" % escape_bbcode(message)
	)
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
