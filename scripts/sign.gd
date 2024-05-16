extends Sprite2D
var player = null
@export var sign_text : String
func _on_area_2d_body_entered(body):
	if body.name == "Phoenix":
		player = body
func _process(_delta):
	if player != null:
		if Input.is_action_just_pressed("sword"):
			$Label.text = sign_text
			$Label.show()
			$Timer.start()


func _on_area_2d_body_exited(body):
	if body.name == "Phoenix":
		player = null


func _on_timer_timeout():
	$Label.hide()
