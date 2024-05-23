extends Area2D
var bomb = null
signal bombed()
func _on_area_entered(area):
	print(area)
	if area.name == "bomb_area":
		bomb = area.get_parent()
func _physics_process(_delta):
	if bomb != null:
		if bomb.boom == true:
			bombed.emit()
