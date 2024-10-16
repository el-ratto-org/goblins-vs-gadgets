extends Node3D

@export var basic_enemy_scene: PackedScene

@onready var lane_scene = $"../Placement"
@onready var spawners = lane_scene.spawners
@onready var spawn_timer = $enemy_spawn_timer

#func _ready() -> void:
	#spawners[0].spawn(basic_enemy_scene)
	#spawners[1].spawn(basic_enemy_scene)

func _on_enemy_spawn_timer_timeout() -> void:
	spawners[0].spawn(basic_enemy_scene)
	spawners[1].spawn(basic_enemy_scene)
	spawners[2].spawn(basic_enemy_scene)
	spawners[3].spawn(basic_enemy_scene)
	spawners[4].spawn(basic_enemy_scene)
