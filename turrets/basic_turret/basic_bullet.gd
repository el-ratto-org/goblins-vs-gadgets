extends CharacterBody3D

@export var damage: float = 1
@export var speed: float = 10

@onready var previous_position = global_position


func _process(delta: float) -> void:
	var interpolated = lerp(
		previous_position,
		global_position,
		Engine.get_physics_interpolation_fraction())
	
	$MeshInstance3D.global_position = interpolated


func _physics_process(delta: float) -> void:
	previous_position = global_position
	velocity.x = speed
	move_and_slide()


func _on_area_3d_area_entered(area: Area3D) -> void:
	queue_free()


func _on_despawn_timer_timeout() -> void:
	queue_free()
