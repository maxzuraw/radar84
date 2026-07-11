extends Node2D

var current_sector := "A-01"
var access_level := 1
var radar_online := true

signal clear_screen()

func execute(command: String) -> String:
	var parts := command.strip_edges().split(" ", false)

	if parts.is_empty():
		return ""

	var command_name := parts[0].to_lower()
	var arguments := parts.slice(1)

	match command_name:
		"help":
			return _help()

		"status":
			return _status()

		"sector":
			return _change_sector(arguments)

		"clear":
			clear_screen.emit()
			return ""
		_:
			return unknown_command(command_name)

func print_command(command: String) -> String:
	return "[color=#a8ffa8]%s[/color]\n" % escape_bbcode(command)

func init_message() -> String:
	return print_system_message("RADAR-84 SYSTEM TERMINAL") + print_system_message("Type HELP for available commands.")
	
func print_system_message(message: String) -> String:
	return "[color=#d5ffd5]%s[/color]\n" % escape_bbcode(message)	

func escape_bbcode(text: String) -> String:
	return text.replace("[", "[lb]").replace("]", "[rb]")
	
func unknown_command(errorMessage: String) -> String:
	return "[color=#ff7777]ERROR: Unknown command %s[/color]\n" % escape_bbcode(errorMessage)

#func execute_scan(arguments: Array[String]) -> void:
	#if arguments.is_empty():
		#print_error("Usage: SCAN <SEKTOR>")
		#return
#
	#var sector := arguments[0].to_upper()
#
	#print_response("Rozpoczynam skan sektora %s..." % sector)
#
	#match sector:
		#"A1":
			#print_response("Brak obiektów.")
#
		#"B4":
			#print_response("Wykryto słaby sygnał.")
			#print_response("ODLEGŁOŚĆ: NIEZNANA")
			#print_response("ROZMIAR: BŁĄD ODCZYTU")
#
		#_:
			#print_response("Sektor %s jest poza zasięgiem radaru." % sector)

func _help() -> String:
	return "AVAILABLE COMMANDS:
HELP\t\t\t\t\t- list of commands
STATUS\t\t\t\t- system status
SCAN <SECTOR>\t- sector scanning
ECHO <TEXT>\t\t- print text
CLEAR\t\t\t\t- clear terminal
PING\t\t\t\t\t- communication test
"


func _status() -> String:
	return "RADAR: %s\nSECTOR: %s\nACCESS LEVEL: %d" % [
		"ONLINE" if radar_online else "OFFLINE",
		current_sector,
		access_level
	] + "\n"


func _change_sector(arguments: Array[String]) -> String:
	if arguments.is_empty():
		return "CURRENT SECTOR: " + current_sector + "\n"

	current_sector = arguments[0].to_upper()
	return "SECTOR CHANGED TO: " + current_sector + "\n"
	
