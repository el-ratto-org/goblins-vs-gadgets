extends Node3D

var is_paused = false
@onready var pause_menu = $Control

func _ready():
	process_mode = Node3D.PROCESS_MODE_ALWAYS


func _input(event):
	if event.is_action_pressed("Pause"):
		toggle_pause_menu()


func toggle_pause_menu():
	is_paused = !is_paused
	pause_menu.visible = is_paused
	get_tree().paused = is_paused


func _on_resume_button_up() -> void:
	toggle_pause_menu()


func _on_restart_button_up() -> void:
	toggle_pause_menu()
	get_tree().reload_current_scene()


func _on_quit_button_up() -> void:
	get_tree().quit()
