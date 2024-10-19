extends CharacterBody3D

@export var damage: float = 1
@export var speed: float = 1
@export var health: int = 3


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


func _on_attack_area_entered(area: Area3D) -> void:
	print("turret damaged")
	if area.owner.is_in_group("Turret"):
		speed = 0
		# TODO: Speed needs to be set back to 1 once the turret is dead

func _on_hurt_box_area_entered(area: Area3D) -> void:
	#apply damage to self, you got shot
	if area.owner.is_in_group("bullet"):
		if health:
			health -= area.owner.damage
		else:
			queue_free()
