extends Sprite2D
func _on_area_2d_body_entered(body):
	if body.name == "Phoenix":
		body.playerData.ruppees += 50
		self.queue_free()
