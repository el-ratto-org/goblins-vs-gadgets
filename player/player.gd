extends Node

# TODO: Change this
@export var basic_turret_scene = preload("res://turrets/basic_turret/basic_turret.tscn")


func _ready() -> void:
	GameManager.placement.connect("on_selection", _cell_selected)


func _cell_selected(cell: Node):
	if !cell.has_turret:
		GameManager.placement.board_cells[cell.index.y][cell.index.x].set_gadget(basic_turret_scene)
