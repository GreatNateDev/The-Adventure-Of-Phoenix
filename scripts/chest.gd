extends Sprite2D
var green_ruppee = preload("res://scenes/green_ruppee.tscn")
@export var item : String
var player = null
var opened = true
func on_player_entered(body):
	if body.name == "Phoenix":
		player = body
func _process(_delta):
	if player != null:
		if item == "green_ruppee":
			if Input.is_action_just_pressed("sword"):
				$AnimationPlayer.play("open")
				var reward = green_ruppee.instantiate()
				get_parent().add_child(reward)
				reward.position = self.position
				reward.position.y -= 5
				opened = true
				
