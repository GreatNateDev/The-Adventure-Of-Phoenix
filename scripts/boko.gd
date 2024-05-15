extends CharacterBody2D
var speed = 30
var damage = 10
var hits = 4
var kbpwr = 2000
var take_kb = false
var timed = false
var mov = false
var default = self.modulate
var dam = Color.RED
@onready var player = get_parent().get_parent().get_node("Phoenix")
func _physics_process(delta):
	if mov == true:
			velocity = (player.get_global_position() - position).normalized() * speed * delta
			move_and_collide(velocity)
func _on_player_intersector_body_entered(body):
	if body.name == "Phoenix":
		player.playerData.hp -= damage
		knockback("player")
func _on_player_intersector_area_entered(area:Area2D):
	if area.name == "sword":
		hits -= player.playerData.power
		damagee()
		mov = false
		if hits <= 0:
			self.queue_free()
func knockback(who):
	if who == "player":
			var kbdir = (velocity - Vector2(0,0)).normalized() *kbpwr
			player.velocity = kbdir
			player.move_and_slide()
func _on_sight_body_entered(body):
	if body.name == "Phoenix":
		mov = true
func _on_sight_body_exited(body):
	if body.name == "Phoenix":
		mov = false
func damagee():
	$Timer.start()
	$boko_sprite.modulate = dam
	await get_tree().create_timer(.3).timeout
	$boko_sprite.modulate = default
	await get_tree().create_timer(.3).timeout
	$boko_sprite.modulate = dam
	await get_tree().create_timer(.3).timeout
	$boko_sprite.modulate = default
func _on_timer_timeout():
	mov = true
