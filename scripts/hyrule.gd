extends Node2D
func _ready():
	if $Phoenix.playerData.first_start == true:
		$Phoenix.cancel_mov = true
		$"Misc/first start".play("run")
		


func _on_first_start_animation_finished(_anim_name):
	$Phoenix.cancel_mov = false
	$Phoenix.playerData.first_start = false
