extends Label3D

func _process(delta: float) -> void:
	self.text = "SCRAP: %s" % GameManager.player.scrap_count
