extends Node3D

var pierce: int
var damage: int


func _on_area_3d_area_entered(area: Area3D) -> void:
	#apply damage
	
	if pierce > 0:
		pierce -= 1
		print("enemy pierced, pierce left: ", pierce)
		return
	queue_free()
