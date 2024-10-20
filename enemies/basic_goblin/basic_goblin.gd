extends CharacterBody3D

@export var damage: float = 1
@export var speed: float = 1
@export var health: int = 3
@onready var attack_timer = $AttackArea/AttackTimer

# Set when instantiated
var lane


func _ready() -> void:
	# Contribute self to placment board
	GameManager.placement.enemy_lanes[lane].append(self)


func _exit_tree() -> void:
	# Determine which lane we're a part of
	var enemy_lane = GameManager.placement.enemy_lanes[lane]
	
	# Find ourselves in the lane
	var our_index = enemy_lane.find(self)
	assert(our_index >= 0, "We aren't in the enemy lane?")
	
	# Remove ourselves from the lane (book-keeping)
	enemy_lane.pop_at(our_index)


func _physics_process(delta: float) -> void:
	velocity.x = -speed
	move_and_slide()
	
	damage_turrt(delta)


func _on_hit_box_area_entered(area: Area3D) -> void:
	#apply damage to self, you got shot
	if area.owner.is_in_group("bullet"):
		if health:
			health -= area.owner.damage
		else:
			queue_free()


var turret_attacked: Node3D = null
func _on_attack_area_entered(area: Area3D) -> void:
	if !area.owner.is_in_group("bullet"):
		speed = 0
		turret_attacked = area.owner


func damage_turrt(delta):
	if turret_attacked:
		turret_attacked.turret_hp -= damage * delta
		print(turret_attacked.turret_hp)

func _on_attack_area_exited(area: Area3D) -> void:
	# mask set to only turret
	# if this runs then a turret broke
	speed = 1
	turret_attacked = null
