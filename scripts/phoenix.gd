extends CharacterBody2D
var hp = 100
var speed = 200
var last_mov = null
var stuck = false
var power = 1
@onready var bar = get_node("CanvasLayer/hpbar")
func _physics_process(_delta):
	bar.value = hp
	if stuck == false:
		var x = Input.get_action_strength("right") - Input.get_action_strength("left")
		var y = Input.get_action_strength("down") - Input.get_action_strength("up")
		var mov = Vector2(x,y)
		if mov == Vector2(0,0):
			pass
		if mov == Vector2(1,0):
			$AnimationPlayer.play("walk_right")
		elif mov == Vector2(-1,0):
			$AnimationPlayer.play("walk_left")
		elif mov == Vector2(0,-1):
			$AnimationPlayer.play("walk_up")
		elif mov == Vector2(0,1):
			$AnimationPlayer.play("walk_down")
		elif velocity == Vector2(0,0) and last_mov == Vector2(speed,0):
			$AnimationPlayer.play("idle_right")
		elif velocity == Vector2(0,0) and last_mov == Vector2(-speed,0):
			$AnimationPlayer.play("idle_left")
		elif velocity == Vector2(0,0) and last_mov == Vector2(0,-speed):
			$AnimationPlayer.play("idle_up")
		elif velocity == Vector2(0,0) and last_mov == Vector2(0,speed):
			$AnimationPlayer.play("idle_down")
		velocity = mov.normalized()*speed
		if Input.is_action_just_pressed("sword"):
			sword()
	last_mov_pos()
	move_and_slide()
func last_mov_pos():
	if velocity != Vector2(0,0):
		last_mov = velocity
func sword():
	stuck = true
	velocity = Vector2(0,0)
	$sword/coll.set_deferred("disabled",false)
	$player_sprite.hide()
	$sword_sprite.show()
	if last_mov == Vector2(speed,0):
		$AnimationPlayer.play("sword_right")
		$sword.rotation_degrees = 0
		await get_tree().create_timer(.5).timeout
	elif last_mov == Vector2(-speed,0):
		$AnimationPlayer.play("sword_left")
		$sword.rotation_degrees = 180
		await get_tree().create_timer(.5).timeout
	elif last_mov == Vector2(0,speed):
		$AnimationPlayer.play("sword_down")
		$sword.rotation_degrees = 90
		await get_tree().create_timer(.5).timeout
	elif last_mov == Vector2(0,-speed):
		$AnimationPlayer.play("sword_up")
		$sword.rotation_degrees = 270
		await get_tree().create_timer(.5).timeout
	stuck = false
	$player_sprite.show()
	$sword_sprite.hide()
	$sword/coll.set_deferred("disabled",true)
