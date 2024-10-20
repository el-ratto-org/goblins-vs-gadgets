extends Node3D

@onready var scrap_timer = $ScrapTimeout
@onready var player = $".."

@onready var label_timeout = $LabelTimeout
@onready var helper_label = $HelperLabel

func _on_gold_timeout_timeout() -> void:
	var scrap_added = 100
	GameManager.player.scrap_count += scrap_added
	# when timer completes, get random wait time for next scrap run
	var random_timeout = randf_range(5, 15)
	# Set timer length
	scrap_timer.wait_time = random_timeout
	scrap_timer.start()
	
	helper_label.text = "Scrap Added: %s" % scrap_added
	label_timeout.start()


func _on_label_timeout_timeout() -> void:
	helper_label.text = ""
