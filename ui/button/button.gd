extends TextureButton

@export var main_text: String
@export var sub_text: String

@onready var main_text_label = $MainTextLabel
@onready var sub_text_label = $SubTextLabel
@onready var animation_player = $AnimationPlayer

func _ready() -> void:
	# Wire up signals
	connect("mouse_entered", _on_mouse_entered)
	connect("mouse_exited", _on_mouse_exited)
	
	# Set text
	main_text_label.text = main_text
	sub_text_label.text = sub_text


func _on_mouse_entered():
	animation_player.play("hover_in")


func _on_mouse_exited():
	animation_player.play("hover_out")
