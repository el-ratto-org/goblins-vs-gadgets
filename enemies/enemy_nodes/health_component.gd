extends Node

# Signals
signal changed(delta: float)

@export var current: float = 100
@export var maximum: float = 100

func change_health(delta: float):
	current += delta
	
	# Emit signal
	changed.emit(delta)
	
func _on_hurt_box_damage_recieved(damage: float) -> void:
	change_health(-damage)
