extends Node
#temp
@export var basic_turret_scene : PackedScene
@onready var board = $"../Stage/Placement"

var enemies = []
var turrets = []

# the get_enemies doesnt work if i spawn the enemies on ready
# i dont like how the board import is lookin like that
# i dont really like this being on the player node
# probs should reorganize the code instead of just emitting and managing it here


func _ready() -> void:
	GameManager.placement.connect("on_selection", _cell_selected)

	for spawner in board.spawners:
		spawner.connect("enemy_spawned", get_enemies)
		
	for row in board.board_cells:
		for cell in row:
			cell.connect("turret_placed", get_turrets)


func _cell_selected(cell: Node):
	if !cell.has_turret:
		GameManager.placement.place_gadget(cell.index, basic_turret_scene)
	else:
		printerr("Cell already has turret on it!")


func get_enemies(enemy, lane) -> void:
	enemies.append({"enemy": enemy, "lane": lane})
func get_turrets(turret, lane) -> void:
	turrets.append({"turret": turret, "lane": lane})


func shoot_turrets() -> void:
	var lanes_with_enemies = {}
	
	for enemy in enemies:
		# check if the enemy is alive
		if is_instance_valid(enemy["enemy"]):
			# if yes, than set lane to active
			lanes_with_enemies[enemy["lane"]] = true
		else:
			# if no, then deleted enemy from list of enemies
			enemies.erase(enemy)
	
	for turret in turrets:
		# for turrets in lane, if enemies in lane then shoot
		if turret["lane"] in lanes_with_enemies:
			turret["turret"].shoot(true)
		else:
			turret["turret"].shoot(false)


func _process(delta: float) -> void:
	shoot_turrets()
