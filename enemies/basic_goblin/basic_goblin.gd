extends CharacterBody3D

@export var damage: float = 1
@export var speed: float = 1


func _physics_process(delta: float) -> void:
	velocity.x = -speed
	move_and_slide()


func _on_attack_area_area_entered(area: Area3D) -> void:
	if area.owner.is_in_group("turret"):
		pass
		#apply damage to turret hp



func _on_hurt_box_area_entered(area: Area3D) -> void:
	if area.owner.is_in_group("bullet"):
		queue_free()
		#apply damage to self
		pass
