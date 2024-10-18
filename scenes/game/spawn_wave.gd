extends Node3D

@export var spawners: Array[Node3D]

var enemies = [
	preload("res://enemies/basic_goblin/basic_goblin.tscn"),
	preload("res://enemies/basic_goblin/basic_goblin.tscn")
]


func calculate_enemy_type() -> Resource:
	var type_index = randi_range(0, len(enemies) - 1)
	return enemies[type_index]


func calculate_lane():
	return randi_range(0, len(spawners) - 1)


func calculate_spawn_position(lane: int):
	return spawners[lane].global_position
