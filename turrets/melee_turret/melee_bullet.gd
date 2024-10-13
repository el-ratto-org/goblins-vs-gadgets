extends Node3D

var pierce: int
var damage: int


func _on_area_3d_area_entered(area: Area3D) -> void:
	#apply damage
	
	if pierce > 0:
		pierce -= 1
		print("enemy pierced, pierce left: ", pierce)
		return
	
	print("Basic Bullet Hit")
	queue_free()


func _on_time_travelled_timer_timeout() -> void:
	queue_free()
