extends Node2D

func _ready():
	global.need_to_lose_100_ruppees = false
	$Label2.text = "Ruppees: " + str(global.ruppees) 
func _on_button_pressed():
	if global.ruppees >= 100:
		global.need_heal = true
		global.need_to_lose_100_ruppees = true
		global.dead = false
		get_tree().change_scene_to_file("res://scenes/hyrule.tscn")
		global.just_entered_building = true
		global.tp_pos = global.respawn_pos


func _on_button_2_pressed():
	global.need_heal = true
	global.dead = false
	get_tree().change_scene_to_file("res://scenes/hyrule.tscn")
	global.just_entered_building = true
	global.tp_pos = Vector2(3212,4553)
