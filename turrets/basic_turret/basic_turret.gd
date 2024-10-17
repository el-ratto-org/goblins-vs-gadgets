extends Node3D

@export var turret_hp = 100

@onready var shoot_timer = $ShootTimer
@onready var barrel_marker = $BarrelMarker
@onready var model_animation = $BaseTurret1/AnimationPlayer
@onready var lane: int

var bullet_scene = preload("./basic_bullet.tscn")

func spawn_bullet():
	var bullet = bullet_scene.instantiate()
	bullet.position = barrel_marker.position
	add_child(bullet)
	model_animation.play("Firing")
	$fire_turret_sfx.play()

func shoot(shoot: bool):
	if shoot_timer.is_stopped() and shoot:
		spawn_bullet()
		barrel_marker.fx_fire()
		shoot_timer.start()
