extends Sprite2D
var selected = false
var target = null
var dftclr = self.modulate
func _ready():
	explode()
func explode():
	self.self_modulate = dftclr
	await get_tree().create_timer(.3).timeout
	self.self_modulate = Color.RED
	await get_tree().create_timer(.3).timeout
	self.self_modulate = dftclr
	await get_tree().create_timer(.3).timeout
	self.self_modulate = Color.RED
	await get_tree().create_timer(.3).timeout
	self.self_modulate = dftclr
	await get_tree().create_timer(.3).timeout
	if target != null:
		print(target)
		target.hits -= 6
		self.queue_free()
	else:
		self.queue_free()
func _on_area_2d_body_entered(body):
	if selected == false and body.name != "Phoenix" and body.name != "ground" and body is CharacterBody2D:
		target = body
		selected = true


func _on_area_2d_body_exited(body):
	if body.name != "Phoenix" and selected == true and body.name != "ground" and body is CharacterBody2D :
		target = null
		selected = false
