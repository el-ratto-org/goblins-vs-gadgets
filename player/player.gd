extends Node3D


@onready var scrap_count = 200 # Starts with 500 scrap

# preset
var selected_turret = null
var selected_turret_model = null


func _ready() -> void:
	GameManager.player = self
	GameManager.placement.connect("on_selection", _cell_selected)
	GameManager.player.connect("turret_selected", _on_buy_menu_turret_selected)


func _cell_selected(cell: Node):
	if !cell.has_turret and selected_turret:
		GameManager.placement.board_cells[cell.index.y][cell.index.x].set_gadget(selected_turret)
		
		# Delete Turret model instance
		selected_turret_model.queue_free()
		
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
