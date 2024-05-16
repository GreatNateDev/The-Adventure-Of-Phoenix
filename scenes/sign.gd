extends Sprite2D
var player = null

func _on_area_2d_body_entered(body):
	if body.name == "Phoenix":
		player = body
func _process(delta):
	if player != null:
		if Input.is_action_just_pressed("sword"):
			pass


func _on_area_2d_body_exited(body):
	if body.name == "Phoenix":
		player = null
