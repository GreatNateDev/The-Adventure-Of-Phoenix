extends Area2D
@export var area = "null"
var phoenix = null
func _on_body_entered(body:Node2D):
	if body.name == "Phoenix":
		phoenix = body
		if area == "sword_cave":
			global.entering_building = true
			$trans_time.start()
		elif area == "b_sword_cave":
			global.entering_building = true
			$trans_time.start()


func _on_trans_time_timeout():
	if area == "sword_cave":
		get_tree().change_scene_to_file("res://scenes/sword_cave.tscn")
		global.just_entered_building = true
	elif area == "b_sword_cave":
		get_tree().change_scene_to_file("res://scenes/hyrule.tscn")
		global.just_entered_building = true
		
		
