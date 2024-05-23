extends Node2D



func _process(_delta):
	if Input.is_anything_pressed():
		get_tree().change_scene_to_file("res://scenes/hyrule.tscn")
