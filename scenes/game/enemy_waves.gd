extends Node3D

#signal spawn_enemy
#emit_signal("spawn_enemy")
@export var basic_enemy_scene: PackedScene
@export var lane_scene: Node3D
@onready var spawners = lane_scene.spawners
@onready var spawn_timer = $enemy_spawn_timer


func _on_enemy_spawn_timer_timeout() -> void:
	spawners[0].spawn(basic_enemy_scene)
	spawners[1].spawn(basic_enemy_scene)
	spawners[2].spawn(basic_enemy_scene)
	spawners[3].spawn(basic_enemy_scene)
	spawners[4].spawn(basic_enemy_scene)
	
	spawn_timer.start()
