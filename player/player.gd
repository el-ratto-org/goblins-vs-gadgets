extends Node3D

@onready var player_gold: int = 0
var scrap_counter_ui # auto adds in scrap counter area
var scrap_count = 100


func _ready() -> void:
	GameManager.player = self
	GameManager.placement.connect("on_selection", _cell_selected)
	GameManager.player.connect("turret_selected", _on_buy_menu_turret_selected)


func _cell_selected(cell: Node):
	print("here")
	if !cell.has_turret and selected_turret:
		GameManager.placement.board_cells[cell.index.y][cell.index.x].set_gadget(selected_turret)
		selected_turret = null


var selected_turret = null
func _on_buy_menu_turret_selected(turret: Variant) -> void:
	selected_turret = turret
