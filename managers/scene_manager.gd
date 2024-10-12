extends Node3D

@onready var animation_player = $AnimationPlayer

var next_scene


func goto_scene(scene: PackedScene):
	animation_player.play("fade_in")
	next_scene = scene


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_in":
		get_tree().change_scene_to_packed(next_scene)
		animation_player.play("fade_out")
