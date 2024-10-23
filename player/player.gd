extends Node3D

# TODO: 
# put floor down on entire group so raycast doesnt catch on edges

@onready var player_gold: int = 0
var scrap_counter_ui # auto adds in scrap counter area
var scrap_count = 100

# preset
var selected_turret = null
var selected_turret_model = null

@onready var camera = $"../Camera3D"
var min_fov: float = 39.8

func _ready() -> void:
	GameManager.player = self
	GameManager.placement.connect("on_selection", _cell_selected)
	GameManager.player.connect("turret_selected", _on_buy_menu_turret_selected)


func _cell_selected(cell: Node):
	if !cell.has_turret and selected_turret:
		GameManager.placement.board_cells[cell.index.y][cell.index.x].set_gadget(selected_turret)
		# Delete Turret model instance
		selected_turret_model.queue_free()
		
		# Zoom in
		zoom(min_fov, camera.fov)
		# Zoom out
		zoom(camera.fov, min_fov)
		
		# Reset selected turret for next turret
		selected_turret_model = null
		selected_turret = null


func _on_buy_menu_turret_selected(turret: Variant, turret_model) -> void:
	# Set turret to be set
	selected_turret = turret
	
	# If turret display model wasnt placed, delete the model
	if selected_turret_model != null:
		selected_turret_model.queue_free()
	
	# Create selected turret model instance
	selected_turret_model = turret_model.instantiate()
	add_child(selected_turret_model)


func _process(delta: float) -> void:
	# Get mouse position
	var mouse_position: Vector2 = get_viewport().get_mouse_position()
	
	# Send Turret model  and  Mouse position
	turret_follow_mouse(selected_turret_model, mouse_position)


func turret_follow_mouse(turret_model: Node3D, mouse_pos: Vector2):
	# Ran if a turret model is given
	if turret_model != null:
		# Getting mouse position in 3D space with ray casting
		var camera = get_viewport().get_camera_3d()
		var origin = camera.project_ray_origin(mouse_pos)
		var normal = origin + camera.project_ray_normal(mouse_pos) * 50 # Ray length
		
		# Create ray from origin to normal
		var ray = PhysicsRayQueryParameters3D.create(origin, normal)
		
		# Perform the raycast
		var space_state = get_world_3d().direct_space_state
		var result = space_state.intersect_ray(ray)
		
		if result:
			turret_model.global_position = result.position


func zoom(target_fov: float, initial_fov: float):
	var elapsed_time = 0.0
	var duration = 0.015
	
	while elapsed_time < duration:
		camera.fov = lerp(initial_fov, target_fov, elapsed_time / duration)
		
		# Time passed
		elapsed_time += get_process_delta_time()
		
		# Timeout for zoom duration, higher the number the longer the zoom
		await get_tree().create_timer(duration/2).timeout
