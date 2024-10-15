extends Node3D

@export var turret_hp = 100

@onready var shoot_timer = $ShootTimer
@onready var barrel_marker = $BarrelMarker
@onready var model_animation = $BaseTurret/AnimationPlayer

var bullet_scene = preload("./basic_bullet.tscn")


func spawn_bullet():
	var bullet = bullet_scene.instantiate()
	bullet.position = barrel_marker.position
	add_child(bullet)
	model_animation.play("Firing")


func _on_shoot_timer_timeout() -> void:
	spawn_bullet()
	shoot_timer.start()
