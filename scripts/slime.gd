extends CharacterBody2D
var speed = 30
var damage = 10
var hits = 4
var kbpwr = 2000
var take_kb = false
var inv = false
var timed = false
var mov = true
@onready var player = get_parent().get_node("Phoenix")
func _physics_process(delta):
	if mov == true:
			velocity = (player.get_global_position() - position).normalized() * speed * delta
			move_and_collide(velocity)
			print($Timer.time_left)
	if $Timer.time_left <= 0.8 and timed == false and not $Timer.time_left <= 0:
		timed = true
		self.hide()
		print("ATTEMPT")
func _on_player_intersector_body_entered(body):
	if body.name == "Phoenix":
		player.hp -= damage
		knockback("player")
func _on_player_intersector_area_entered(area:Area2D):
	if area.name == "sword" and inv == false:
		hits -= player.power
		inv = true
		$Timer.start()
		mov = false
		if hits <= 0:
			self.queue_free()
func knockback(who):
	if who == "player":
			var kbdir = (velocity - Vector2(0,0)).normalized() *kbpwr
			player.velocity = kbdir
			player.move_and_slide()
func _on_timer_timeout():
	inv = false
	timed = false
	mov = true
	self.show()
