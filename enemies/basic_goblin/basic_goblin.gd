extends Node3D

@export var damage: float = 1
@export var speed: float = 1
@export var health: float = 3

@onready var attack_timer = $AttackArea/AttackTimer

# Set when instantiated
var lane

# The turret currently being attacked
var turret_attacking: Node3D = null


func _ready() -> void:
	# Contribute self to placment board
	GameManager.placement.enemy_lanes[lane].append(self)


func _exit_tree() -> void:
	# Determine which lane we're a part of
	var enemy_lane = GameManager.placement.enemy_lanes[lane]
	
	# Find ourselves in the lane
	var our_index = enemy_lane.find(self)
	assert(our_index >= 0, "We aren't in a enemy lane?")
	
	# Remove ourselves from the lane (book-keeping)
	enemy_lane.pop_at(our_index)


func _process(delta: float) -> void:
	# Is there a turret to attack?
	if turret_attacking:
		# Attack the turret (do damage)
		turret_attacking.turret_hp -= damage * delta
	else:
		# Otherwise, move
		position.x -= speed * delta


func _on_hit_box_area_entered(area: Area3D) -> void:
	assert(area.owner.is_in_group("bullet"), "Got shot by something, which isn't a bullet?")
	var incoming_damage = area.owner.damage
	
	# Do we have enough health to live?
	if health > incoming_damage:
		# Apply damage to self, you got shot
		health -= incoming_damage
	else:
		# We don't have enough health,
		# so we die
		queue_free()


func _on_attack_area_entered(area: Area3D) -> void:
	if !area.owner.is_in_group("bullet"):
		turret_attacking = area.owner


func _on_attack_area_exited(area: Area3D) -> void:
	# Mask set to only turret,
	# if this runs then a turret broke
	turret_attacking = null
