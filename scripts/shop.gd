extends Sprite2D
var player = null


func _process(delta):
	if player != null:
		if Input.is_action_just_pressed("sword"):
			pass
			#contenue tmr


func body_entered(body):
	if body.name == "Phoenix":
		player=body


func body_exit(body):
	if player != null:
		player=null
