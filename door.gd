extends Area2D
@export var area = "sub_0"

func _on_body_entered(body:Node2D):
	if body.name == "Phoenix":
		if area == "sub_0":
			pass
		elif area == "sub_1":
			pass