extends Node3D

@export var turret_hp = 100

@onready var shoot_timer = $ShootTimer
@onready var barrel_marker = $BarrelMarker
@onready var model_animation = $BaseTurret1/AnimationPlayer
@onready var fire_turret_sfx = $FireTurretSfx

var bullet_scene = preload("./basic_bullet.tscn")

# Set when instantiated
var index


func spawn_bullet():
	var bullet = bullet_scene.instantiate()
	bullet.position = barrel_marker.position
	add_child(bullet)
	model_animation.play("Firing")
	if !fire_turret_sfx.is_playing():
		fire_turret_sfx.play()


func _on_shoot_timer_timeout():
	# Determine which enemies are on our lane
	var enemies_in_lane = GameManager.placement.enemy_lanes[index.y]
	
	# Ensure we have enemies in our lane
	if len(enemies_in_lane) > 0:
		# Shoot them
		spawn_bullet()
		barrel_marker.fx_fire()
		shoot_timer.start()
