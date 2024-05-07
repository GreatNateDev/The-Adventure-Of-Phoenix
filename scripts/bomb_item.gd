extends Sprite2D

@onready var doggo = get_parent().get_node("dog/Label")
func _ready():
	if global.player.playerData.has_bombs == true:
		doggo.queue_free()
		self.queue_free()
func _on_area_2d_body_entered(body:Node2D):
	if body.name == "Phoenix":
		body.playerData.has_bombs = true
		self.queue_free()
