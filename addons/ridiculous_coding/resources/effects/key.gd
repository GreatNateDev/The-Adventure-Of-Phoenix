@tool
class_name RcKey extends Node

var destroy:bool = false
var last_key:String = ""
var animation_name:String = "default"

@onready var animation_player:AnimationPlayer = $AnimationPlayer
@onready var key_label:Label = $Label
@onready var timer:Timer = $Timer

func _ready() -> void:
	key_label.text = last_key
	animation_player.play(animation_name)
	timer.start()

func set_key_color(r1:float,r2:float,g1:float,g2:float,b1:float,b2:float,a1:float,a2:float) -> void:
	key_label.modulate = Color(randf_range(r1,r2),randf_range(g1,g2),randf_range(b1,b2),randf_range(a1,a2))

func _on_timer_timeout() -> void: if destroy == true: queue_free()
