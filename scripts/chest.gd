extends Sprite2D
@export var item : String
var item_for_func : PackedScene
var player = null
var opened = true
var spawned = false
func _physics_process(delta):
	if item == "green_ruppee":
		item_for_func = preload("res://scenes/green_ruppee.tscn")
	elif item == "blue_ruppee":
		item_for_func = preload("res://scenes/blue_ruppee.tscn")
	elif item == "red_ruppee":
		item_for_func = preload("res://scenes/red_ruppee.tscn")
	elif item == "purple_ruppee":
		item_for_func = preload("res://scenes/purple_ruppee.tscn")
	elif item == "gold_ruppee":
		item_for_func = preload("res://scenes/gold_ruppee.tscn")
func on_player_entered(body):
	if body.name == "Phoenix":
		player = body
func _process(_delta):
	if spawned == false:
		if player != null:
			if Input.is_action_just_pressed("sword"):
				print(item_for_func)
				run(item_for_func)
func run(itom : PackedScene):
	spawned = true
	$AnimationPlayer.play("open")
	var reward = itom.instantiate()
	get_parent().add_child(reward)
	reward.position = self.position
	reward.position.y -= 5
