extends Control

@export var loaded_progress: float = 0

@onready var spinner_semicircle = $Spinner/SemiCircle
@onready var progress_text = $Bar/ProgressText
@onready var empty_bar = $Bar/Empty
@onready var filled_bar = $Bar/Filled
@onready var bar_mask = $Bar/BarMask


func _process(delta: float) -> void:
	spinner_semicircle.rotation += delta * 10
	
	progress_text.text = "%d%%" % (loaded_progress * 100)
	var maximum_size = empty_bar.size.x
	
	var bar_width = loaded_progress * maximum_size
	filled_bar.size.x = bar_width
	bar_mask.position.x = bar_width
	bar_mask.size.x = maximum_size - bar_width
