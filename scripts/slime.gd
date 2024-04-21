extends CharacterBody2D
var speed = 20
var damage = 10
var hits = 4
var kbpwr = 700
var take_kb = false
var inv = false
@onready var player = get_parent().get_node("Phoenix")
func _physics_process(delta):
		velocity = (player.get_global_position() - position).normalized() * speed * delta
		move_and_collide(velocity)
		for body in $player_intersector.get_overlapping_bodies():
			if body.name == "Phoenix":
				pass
				#fix kb stuffs
func _on_player_intersector_body_entered(body):
	if body.name == "Phoenix":
		player.hp -= damage
		knockback("player")


func _on_player_intersector_area_entered(area:Area2D):
	if area.name == "sword" and inv == false:
		hits -= player.power
		print("hit")
		#knockback("self")
		inv = true
		$Timer.start()
func knockback(who):
	if who == "player":
			var kbdir = (player.last_mov - velocity).normalized() *kbpwr
			player.velocity = kbdir
			player.move_and_slide()
	#elif who == "self":
		#var kbdir = (self.velocity + player.last_mov).normalized() * kbpwr
		#self.velocity = kbdir
		#self.move_and_slide()
		#kb Code
func _on_timer_timeout():
	inv = false
