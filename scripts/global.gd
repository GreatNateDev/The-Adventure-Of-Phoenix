extends Node
@onready var player = null
var just_entered_building = false
var entering_building = false
var tp_pos = Vector2(0,0)
var need_to_lose_100_ruppees = false
var respawn_pos : Vector2
var need_heal = false
var dead = false
var ruppees :int
