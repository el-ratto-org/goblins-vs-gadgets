extends Node

# Signals
signal changed(delta: float)

@export var current: float = 100
@export var maximum: float = 100

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("debug"):
		change_health(-1)

func change_health(delta: float):
	current += delta
	
	# Emit signal
	changed.emit(delta)
	
func _on_hurt_box_damage_recieved(damage: float) -> void:
	change_health(-damage)
