extends Area2D
@export var dir : String
@export var len : int
var player = null
func _physics_process(delta):
	if player != null:
		if dir == "up":
			player.position.y -= len
		elif dir == "down":
			player.position.y += len
		elif dir == "left":
			player.position.x -= len
		elif dir == "right":
			player.position.x += len
func _on_body_entered(body):
	if body.name == "Phoenix":
		player = body
func _on_body_exited(body):
	if body.name == "Phoenix":
		player = null
