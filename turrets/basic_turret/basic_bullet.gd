extends CharacterBody3D

@export var damage: float = 1
@export var speed: float = 10


func _physics_process(delta: float) -> void:
	velocity.x = speed
	move_and_slide()


func _on_area_3d_area_entered(area: Area3D) -> void:
	queue_free()
