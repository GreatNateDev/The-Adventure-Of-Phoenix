extends Sprite2D
var selected = false
var target = null
var dftclr = self.modulate
func _ready():
	explode()
func explode():
	self.modulate = Color.WHITE
	await get_tree().create_timer(.3).timeout
	self.modulate = dftclr
	await get_tree().create_timer(.3).timeout
	self.modulate = Color.WHITE
	await get_tree().create_timer(.3).timeout
	self.modulate = dftclr
	await get_tree().create_timer(.3).timeout
	self.modulate = Color.WHITE
	await get_tree().create_timer(.3).timeout
	self.modulate = dftclr
	await get_tree().create_timer(.3).timeout
	if target != null:
		target.hits -= 6
func _on_area_2d_body_entered(body):
	if selected == false and body.name != "Phoenix":
		target = body
		selected = true


func _on_area_2d_body_exited(body):
	if body.name != "Phoenix" and selected == true:
		target = null
		selected = false
