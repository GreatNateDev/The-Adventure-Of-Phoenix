extends Sprite2D

func _on_area_2d_body_entered(body:Node2D):
	if body.name == "Phoenix":
		body.playerData.has_sword = true
		self.queue_free()
