extends Node
#temp
@export var basic_turret_scene : PackedScene

func _ready() -> void:
	GameManager.placement.connect("on_selection", _cell_selected)


func _cell_selected(cell: Node):
	var turret = basic_turret_scene.instantiate()
	turret.turret_cell = cell
	add_child(turret)
	print("cell selected: ", cell)
