extends CharacterBody2D
var last_mov = Vector2(0,0)
var cool = false
var move = true
var mov
var save_file_path = "user://save/"
var save_file_name = "Player.tres"
var playerData = SaveData.new()
var cancel_mov = false
@export var enable_cam = true
@onready var bar = get_node("CanvasLayer/hpbar")
func load_sav():
	playerData = ResourceLoader.load(save_file_path+save_file_name).duplicate(true)
func save():
	ResourceSaver.save(playerData,save_file_path+save_file_name)
func _ready():
	global.player = self
	verify_save_directory(save_file_path)
	if global.just_entered_building == true:
		load_sav()
		if global.need_heal == true:
			playerData.hp = 100
			global.need_heal = false
		global.just_entered_building = false
	if enable_cam == false:
		$cam.enabled = false
	if playerData.has_bombs == true:
		$CanvasLayer/bomb_num.show()
		$CanvasLayer/bomb_sprite.show()
func  verify_save_directory(path):
	DirAccess.make_dir_absolute(path)
func _physics_process(_delta):
	$"CanvasLayer/Control/ruppee counter".text = str(playerData.ruppees)
	if global.entering_building == true:
		save()
		global.entering_building = false
	if global.tp_pos != Vector2(0,0):
		self.position = global.tp_pos
		global.tp_pos = Vector2(0,0)
	bar.value = playerData.hp
	var x = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y = Input.get_action_strength("down") - Input.get_action_strength("up")
	if move == true:
		mov = Vector2(x,y)
	elif move == false:
		mov = Vector2(0,0)
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
	elif velocity == Vector2(0,0) and last_mov == Vector2(playerData.speed,0):
		$AnimationPlayer.play("idle_right")
	elif velocity == Vector2(0,0) and last_mov == Vector2(-playerData.speed,0):
		$AnimationPlayer.play("idle_left")
	elif velocity == Vector2(0,0) and last_mov == Vector2(0,-playerData.speed):
		$AnimationPlayer.play("idle_up")
	elif velocity == Vector2(0,0) and last_mov == Vector2(0,playerData.speed):
		$AnimationPlayer.play("idle_down")
	if cancel_mov == false:
		velocity = mov.normalized()*playerData.speed
	elif cancel_mov == true:
		velocity = Vector2(0,0)
	if Input.is_action_just_pressed("sword") and cool == false:
		sword()
	if Input.is_action_just_pressed("bomb") and cool == false and playerData.bombs != 0 and playerData.has_bombs == true:
		bomb()
	if playerData.hp <=0:
		die()
	if playerData.hp > playerData.max_hp:
		playerData.hp = playerData.max_hp
	last_mov_pos()
	move_and_slide()
	if global.need_to_lose_100_ruppees == true:
		if playerData.ruppees >= 100:
			playerData.ruppees -=100
			global.need_to_lose_100_ruppees = false
			pass
		elif playerData.ruppees <= 100:
			die()
	$CanvasLayer/bomb_num.text = str(playerData.bombs)
func last_mov_pos():
	if velocity != Vector2(0,0):
		last_mov = velocity
func sword():
	if playerData.has_sword == true:
		$sword_swing.play()
		pass
	elif playerData.has_sword == false:
		return
	velocity = Vector2(0,0)
	$sword/coll.set_deferred("disabled",false)
	$player_sprite.hide()
	$sword_sprite.show()
	move = false
	if last_mov == Vector2(playerData.speed,0):
		$AnimationPlayer.play("sword_right")
		$sword.rotation_degrees = 0
		await get_tree().create_timer(.5).timeout
	elif last_mov == Vector2(-playerData.speed,0):
		$AnimationPlayer.play("sword_left")
		$sword.rotation_degrees = 180
		await get_tree().create_timer(.5).timeout
	elif last_mov == Vector2(0,playerData.speed):
		$AnimationPlayer.play("sword_down")
		$sword.rotation_degrees = 90
		await get_tree().create_timer(.5).timeout
	elif last_mov == Vector2(0,-playerData.speed):
		$AnimationPlayer.play("sword_up")
		$sword.rotation_degrees = 270
		await get_tree().create_timer(.5).timeout
	$player_sprite.show()
	$sword_sprite.hide()
	$sword/coll.set_deferred("disabled",true)
	cool = true
	$sword_cooldown.start()
	move = true
func _on_sword_cooldown_timeout():
	cool = false
func die():
	if global.need_heal == false and global.dead == false:
		global.ruppees = playerData.ruppees
		global.dead = true
		global.respawn_pos = self.position
		global.entering_building = true
		$death_await.start()


func _on_death_await_timeout():
	get_tree().change_scene_to_file("res://scenes/misc/death_screen.tscn")

func bomb():
	playerData.bombs -= 1
	var bomb_spn = preload("res://scenes/entitys/bomb.tscn")
	var b = bomb_spn.instantiate()
	get_parent().add_child(b)
	b.position = self.position
