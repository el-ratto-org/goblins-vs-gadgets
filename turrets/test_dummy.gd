extends Node3D

var dps: float = 0.0
@onready var damage_taken: float = 0.0
@onready var basic_turret: Node = $"../Basic Turret"


func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.owner.is_in_group("turret_bullet"):
		damage_taken += basic_turret.damage


func _on_timer_timeout() -> void:
	$Label3D.text = "Dummy\n %s" % str(damage_taken)
	damage_taken = 0.0
