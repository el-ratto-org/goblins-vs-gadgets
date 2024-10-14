extends Node

@export var base_move_speed : float = 25
@export var target : RigidBody3D

@onready var forward_dir : Vector3 = Vector3.ZERO
@onready var inpulses : Vector3 = Vector3.ZERO
@onready var current_speed_modifier = 1

func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	forward_dir.x -= base_move_speed * current_speed_modifier


func apply_speed_modifer(amount: float) -> void:
	# amount is float [0, 1]
	# e.g. 0.25 will make the enemy move at 25% speed
	
	current_speed_modifier *= amount
	print("Current speed modifier for ",target," = ",current_speed_modifier)


func get_movement_data() -> Dictionary:
	return {
		"forward_dir": forward_dir, # moving vel
		"impulses": inpulses, # impulse forces ie damage
	}


func _on_health_changed(delta: float) -> void:
	if delta < 0: # damaged
		print("impulsing")
		
		inpulses.x += delta
		
