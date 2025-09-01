extends Node3D

var obsticle1 = load("res://Scenes/block_1.tscn")
@onready var SpawnTimer: Timer = $Timer
var instance
@export var player : Player
@onready var despawn: Area3D = $Despawn
var l = 0
var last_inst


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#obs1 = obsticle1.instantiate()
	SpawnTimer.wait_time += randi_range(0, 2)
	player.connect("Parry", _on_parry_recieved)

func _physics_process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	instance = obsticle1.instantiate()
	instance.player = $"../Player"
	add_child(instance)
	SpawnTimer.start()
	if l == 0:
		last_inst = instance
		l += 1

func _on_parry_recieved():
	last_inst.apply_force(Vector3(-10000, 0, -10000))
	print("Worked")


func _on_despawn_area_entered(area: Area3D) -> void:
	last_inst = instance


func _on_reset_area_entered(area: Area3D) -> void:
	print(area)
	#if area == instance.area_3d:
		#instance = area.get_parent()
