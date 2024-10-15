extends Node3D
signal enemy_spawned

@export var basic_enemy_scene: PackedScene
@onready var lane: int


func spawn(enemy_scene):
	var new_enemy = enemy_scene.instantiate()
	new_enemy.global_position = global_position
	emit_signal("enemy_spawned", new_enemy, lane)
	#new_enemy.global_position
