extends Node2D

var current_sector := "I-9"
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
			return _help(arguments)

		"status":
			return _status()

		"sector":
			return _change_sector(arguments)

		"clear","cls":
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

func bad_sector_format(errorMessage: String) -> String:
	return "[color=#ff7777]Bad sector format: was entered %s, should be in format <character>-<number>[/color]\n" % escape_bbcode(errorMessage)

func bad_sector_name(errorMessage: String) -> String:
	return "[color=#ff7777]Bad sector name: was entered %s, check your map for sectors[/color]\n" % escape_bbcode(errorMessage)
	
func command_without_arguments(errorMessage: String) -> String:
	return "[color=#ff7777]ERROR: Command %s does not have any arguments[/color]\n" % escape_bbcode(errorMessage)

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

func _help(arguments: Array[String]) -> String:
	if arguments.is_empty():
		return "AVAILABLE COMMANDS:
	HELP\t\t\t\t\t\t- list of commands
	HELP <COMMAND>\t\t- list of possible arguments for command if available
	STATUS\t\t\t\t\t- system status
	SECTOR\t\t\t\t\t- current sector status (*)
	SCAN\t\t\t\t\t\t- scan current sector
	CLEAR\t\t\t\t\t- clear terminal
	* - contains additional arguments
	"
	
	var argument := arguments[0].to_lower()
	match argument:
		"help":
			return "CHOOSE WISELY COMMAND TO HELP FOR\n"
		"sector":
			return "SECTOR\t\t\t\t\t\t\t- sector status\nSECTOR <SECTOR_NAME>\t- changes to sector with SECTOR_NAME. SECTOR_NAME has format '<LETTER>-<NUMBER>'. Check map for names of sector.\n"

		_:
			return command_without_arguments(argument)


func _status() -> String:
	return "RADAR: %s\nSECTOR: %s\nACCESS LEVEL: %d" % [
		"ONLINE" if radar_online else "OFFLINE",
		current_sector,
		access_level
	] + "\n"


func _change_sector(arguments: Array[String]) -> String:
	if arguments.is_empty():
		return "CURRENT SECTOR: " + current_sector + "\n"

	var upperCase = arguments[0].to_upper()
	
	# walidacja wpisanego argumentu
	if not upperCase.contains("-"):
		return bad_sector_format(upperCase)
		
	var podzielone = upperCase.split("-")
	if podzielone.size() > 2:
		return bad_sector_format(upperCase)
	
	var allowed_letters = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'R', 'S']
	
	if podzielone[0] not in allowed_letters:
		return bad_sector_name(upperCase)
	
	var numerSektora = 0
	if podzielone[1].is_valid_int():
		numerSektora = podzielone[1].to_int()
	else:
		return bad_sector_name(upperCase)
	
	if numerSektora > 18 or numerSektora < 1:
		return bad_sector_name(upperCase)
		
	current_sector = upperCase
	return "SECTOR CHANGED TO: " + current_sector + "\n"
	
