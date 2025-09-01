extends Node3D

@onready var player = get_parent()

func _process(delta):
	var player_x = player.global_position.x
	var new_position = global_position
	new_position.x = player_x
	global_position = new_position
