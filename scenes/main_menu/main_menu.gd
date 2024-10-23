extends Control

@export var play_scene: PackedScene


func _on_play_button_up() -> void:
	SceneManager.goto_scene(play_scene)


func _on_mini_games_button_up() -> void:
	SceneManager.goto_scene(play_scene)


func _on_exit_button_up() -> void:
	get_tree().quit()
