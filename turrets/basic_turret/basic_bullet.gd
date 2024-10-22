extends Node3D

@export var damage: float = 1
@export var speed: float = 10


func _process(delta: float) -> void:
	position.x += speed * delta


func _on_area_3d_area_entered(area: Area3D) -> void:
	assert(area.owner.is_in_group("enemy"), "Hit something which is not an enemy?")
	queue_free()


func _on_despawn_timer_timeout() -> void:
	queue_free()
