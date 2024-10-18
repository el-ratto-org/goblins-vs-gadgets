extends Marker3D

@onready var fx_fire_scene = preload("res://turrets/basic_turret/fx_fire_base_turret.tscn")
# Called when the node enters the scene tree for the first time.

	
func fx_fire():
	var fx_fire_instance = fx_fire_scene.instantiate()
	add_child(fx_fire_instance)
