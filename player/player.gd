extends Node
#temp
@export var basic_turret_scene : PackedScene

func _ready() -> void:
	GameManager.placement.connect("on_selection", _cell_selected)


func _cell_selected(cell: Node):
	if !cell.has_turret:
		GameManager.placement.place_gadget(cell.index, basic_turret_scene)
	else:
		printerr("Cell already has turret on it!")
