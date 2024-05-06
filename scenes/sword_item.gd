extends Sprite2D
@onready var cat = get_parent().get_node("cat/Label")
func _ready():
	if global.player.playerData.has_sword == true:
		cat.queue_free()
		self.queue_free()
func _on_area_2d_body_entered(body:Node2D):
	if body.name == "Phoenix":
		body.playerData.has_sword = true
		self.queue_free()
