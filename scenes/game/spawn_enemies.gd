extends Node3D

@onready var lane: int
var platform_height_offset = 1

#signal spawn_enemy
#func _ready() -> void:
	#connect("spawn_enemy", _on_spawn_enemy)
#func _on_spawn_enemy() -> void:
	#spawn(basic_enemy_scene)
	#print("received")

func spawn(enemy_scene):
	var new_enemy = enemy_scene.instantiate()
	add_child(new_enemy)
	
	new_enemy.global_position = global_position
	new_enemy.global_position.y = global_position.y + platform_height_offset
	emit_signal("enemy_spawned", new_enemy, lane)
