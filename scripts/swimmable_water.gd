extends Area2D
@export var dir : String
@export var length : int
var player = null
func _physics_process(_delta):
	if player != null:
		if dir == "up":
			player.position.y -= length
		elif dir == "down":
			player.position.y += length
		elif dir == "left":
			player.position.x -= length
		elif dir == "right":
			player.position.x += length
func _on_body_entered(body):
	if body.name == "Phoenix":
		player = body
func _on_body_exited(body):
	if body.name == "Phoenix":
		player = null
