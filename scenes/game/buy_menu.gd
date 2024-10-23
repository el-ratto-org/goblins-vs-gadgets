extends CanvasLayer
signal turret_selected(turret, turret_model)

@export var menu_container: MarginContainer
@export var hide_button: Button
@export var toggle_menu: CheckBox

@export var basic_turret_button: Button
@export var basic_turret_button2: Button


func _ready() -> void:
	_on_hide_button_toggled(false)
	
	basic_turret_button.pressed.connect(_on_turret_pressed.bind(basic_turret_button))
	basic_turret_button2.pressed.connect(_on_turret_pressed.bind(basic_turret_button2))


func _on_turret_pressed(button) -> void:
	emit_signal("turret_selected", button.turret, button.turret_model)
	
	if !menu_hide_toggle:
		_on_hide_button_toggled(false)


func _on_hide_button_toggled(toggled_on: bool) -> void:
	var screen_height = get_window().size.y
	
	if toggled_on:
		# Ran when menu is down and is going up
		menu_container.global_position.y = screen_height * .73
		hide_button.text = "˅"
	else:
		# Ran when menu is up and is going down
		menu_container.global_position.y = screen_height * .94
		hide_button.text = "^"

# Start with Menu hidden
var menu_hide_toggle = false
func _on_toggle_menu_hide_toggled(toggled_on: bool) -> void:
	menu_hide_toggle = toggled_on
