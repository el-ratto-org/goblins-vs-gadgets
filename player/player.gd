extends Node
#temp
@export var basic_turret_scene : PackedScene

func _ready() -> void:
	GameManager.placement.connect("on_selection", _cell_selected)


func _cell_selected(cell: Node):
	if !cell.has_turret:
		var turret = basic_turret_scene.instantiate()
		turret.turret_cell = cell
		cell.has_turret = true
		get_parent().add_child(turret)
		print("Cell selected: ", cell)
	else:
		print("Cell already has turret on it!")
