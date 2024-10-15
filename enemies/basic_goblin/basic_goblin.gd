extends CharacterBody3D

@export var damage: float = 1
@export var speed: float = 10
@onready var spawn_position: Vector3

func _ready() -> void:
	# get position with Vector3 to start of lane
	global_position = spawn_position

func _physics_process(delta: float) -> void:
	velocity.x = speed
	move_and_slide()


func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.owner.is_in_group("turret"):
		pass
		#apply damage
