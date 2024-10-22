extends Node3D

@onready var animation_player = $AnimationPlayer
@onready var fake_loading_time = $FakeLoadingTime
@onready var loading_bar = $CanvasLayer/Fade/LoadingBar

var next_scene


func _process(delta: float) -> void:
	loading_bar.loaded_progress = clamp(loading_bar.loaded_progress + delta, 0, 1)


func goto_scene(scene: PackedScene):
	loading_bar.loaded_progress = 0
	animation_player.play("fade_in")
	next_scene = scene


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_in":
		fake_loading_time.start()
		#get_tree().change_scene_to_packed(next_scene)
		#animation_player.play("fade_out")


func _on_fake_loading_time_timeout() -> void:
	# TODO: Move back into `_on_animation_player_animation_finished`
	get_tree().change_scene_to_packed(next_scene)
	animation_player.play("fade_out")
