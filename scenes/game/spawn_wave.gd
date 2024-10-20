extends Node3D

@export var spawners: Array[Node3D]

var enemies = [
	preload("res://enemies/basic_goblin/basic_goblin.tscn"),
	preload("res://enemies/basic_goblin/basic_goblin.tscn")
]


func calculate_enemy_type() -> Resource:
	var type_index = randi_range(0, len(enemies) - 1)
	return enemies[type_index]


func calculate_lane(previous_lane):
	var suggested_lane = randi_range(0, len(spawners) - 1)
	while suggested_lane == previous_lane:
		suggested_lane = randi_range(0, len(spawners) - 1)
	return suggested_lane


func calculate_spawn_position(lane: int):
	return spawners[lane].global_position
