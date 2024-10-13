extends Node3D

@export var bullet_scene : PackedScene
@export var turret_hp = 100

@export var bullet_speed = 300
@export var bullet_pierce = 0
@export var damage = 1

var can_shoot = true
var turret_cell: Node3D


#func _ready() -> void:
	# set turret position to cell on board
	#global_position = turret_cell.position
	#if GameManager.placement.enemy_lanes[turret_cell.cell_position.y] and can_shoot:
		#spawn_bullet()
		#can_shoot = false
		#$fire_rate_timer.start()

func _process(delta: float) -> void:
	# for test node
	if can_shoot:
		spawn_bullet()
		can_shoot = false
		$fire_rate_timer.start()

func _on_fire_rate_timer_timeout() -> void:
	can_shoot = true


func spawn_bullet():
	# create bullets
	var bullet = bullet_scene.instantiate()
	add_sibling(bullet) # spawn bullet in turrets scene
	
	# change bullet stats
	bullet.pierce = bullet_pierce
	bullet.damage = damage
	bullet.position = self.position
	bullet.add_constant_force(Vector3(0, 0, bullet_speed))
