extends Node3D

@export var basic_enemy_scene: PackedScene
@onready var spawn_timer = $enemy_start_spawn_timer
@onready var board = $"../Placement"
@onready var spawners = board.spawners
@onready var num_enemies = 15
@onready var enemies = [basic_enemy_scene, basic_enemy_scene]

var max_enemies_per_lane = 4
var curret_enemies = []
var turrets = []
var lanes_with_enemies = []

func _ready() -> void:
	for spawner in board.spawners:
		spawner.connect("enemy_spawned", get_enemies)
		
	for row in board.board_cells:
		for cell in row:
			cell.connect("turret_placed", get_turrets)
	# run this to start the wave
	for lane in board.enemy_lanes:
		lanes_with_enemies.append([])
	spawn_enemies_randomly()


func _process(delta: float) -> void:
	shoot_turrets()


func get_enemies(enemy, lane) -> void:
	curret_enemies.append({"enemy": enemy, "lane": lane})
func get_turrets(turret, lane) -> void:
	turrets.append({"turret": turret, "lane": lane})


func shoot_turrets() -> void:	
	for enemy in curret_enemies:
		# check if the enemy is alive
		if is_instance_valid(enemy["enemy"]) and enemy["enemy"] not in lanes_with_enemies[enemy["lane"]]:
			# if yes, then add them to their lane
			lanes_with_enemies[enemy["lane"]].append(enemy["enemy"])
		elif !is_instance_valid(enemy["enemy"]):
			# if no, then remove that enemy from the array
			lanes_with_enemies[enemy["lane"]].erase(enemy["enemy"])
		
		for turret in turrets:
			# shoot if the turrets lanes has an enemy in it
			turret["turret"].shoot(len(lanes_with_enemies[turret["lane"]]) > 0)


func spawn_enemies_randomly() -> void:
	spawn_timer.start()
	# get timers duration
	var spawn_duration = spawn_timer.wait_time
	# average time between spawns
	var spawn_interval = spawn_duration / num_enemies  
	
	# spawn enemies
	var prev_lane = 0
	for i in range(num_enemies):
		# random wait time to spread enemies out
		var random_delay = randf_range(0.20, spawn_interval)
		await get_tree().create_timer(random_delay).timeout
		
		# pick random lane and enemy
		var random_spawner = randi() % spawners.size()
		var random_enemy = randi() % enemies.size()
		
		# if lane has more than the average num of enemies per lane, try again
		if len(lanes_with_enemies[random_spawner]) > num_enemies / len(lanes_with_enemies):
			random_spawner = check_spawner_roll(prev_lane, random_spawner)
		
		# Spawn the random enemy on the random spawner
		spawners[random_spawner].spawn(enemies[random_enemy])


func check_spawner_roll(prev_lane, lane_roll):
	while prev_lane == lane_roll:
		lane_roll = randi() % spawners.size()
		print("rerolling lane for enemy spawn")
	return lane_roll
