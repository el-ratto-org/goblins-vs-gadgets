extends CanvasLayer
signal turret_selected(turret)

@export var menu_container: MarginContainer
@export var hide_button: Button
@export var toggle_menu: CheckBox

@export var basic_turret_button: Button
@export var basic_turret_button2: Button


func _ready() -> void:
	menu_container.global_position.y = 675
	
	basic_turret_button.pressed.connect(_on_turret_pressed.bind(basic_turret_button))
	basic_turret_button2.pressed.connect(_on_turret_pressed.bind(basic_turret_button2))


# TODO: These need to be dynamic with screen size
var menu_down_position = 675
var menu_up_position = 520

func _on_turret_pressed(button) -> void:
	emit_signal("turret_selected", button.turret)
	
	# returns the state of the toggle meny
	
	if !menu_hide_toggle:
		hide_button.set_pressed(false)
		menu_container.global_position.y = menu_down_position
		hide_button.text = "^"
	
	print("turret_selected", button.turret)


func _on_hide_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		menu_container.global_position.y = menu_up_position
		hide_button.text = "˅"
	else:
		menu_container.global_position.y = menu_down_position
		hide_button.text = "^"


var menu_hide_toggle = false
func _on_toggle_menu_hide_toggled(toggled_on: bool) -> void:
	menu_hide_toggle = toggled_on
