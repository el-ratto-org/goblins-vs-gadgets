extends Control

@export var play_scene: PackedScene


func _on_button_button_up() -> void:
	SceneManager.goto_scene(play_scene)
