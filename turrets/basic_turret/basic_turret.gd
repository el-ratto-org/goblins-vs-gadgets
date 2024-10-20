extends Node3D

@export var turret_hp = 10

@onready var shoot_timer = $ShootTimer
@onready var barrel_marker = $BarrelMarker
@onready var model_animation = $BaseTurret1/AnimationPlayer
@onready var fire_turret_sfx = $FireTurretSfx
@onready var damage_timeout = $HitBox/CheckDamgeTimeout

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


var hurtbox_area: Area3D
func _on_hurtbox_area_entered(area: Area3D) -> void:
	#apply damage to self, you got smacked
	if area.owner.is_in_group("Enemy"):
		hurtbox_area = area
		_on_check_damge_timeout()


func _on_check_damge_timeout() -> void:
	if turret_hp and is_instance_valid(hurtbox_area):
		turret_hp -= hurtbox_area.owner.damage
		print(turret_hp)
		damage_timeout.start()
	else:
		queue_free()
		# TODO: Needs to tell cell there isnt a turret there anymore
		#GameManager.placement.board_cells.cell.remove_gadget(self)
