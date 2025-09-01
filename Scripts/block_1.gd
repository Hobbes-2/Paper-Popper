extends RigidBody3D
@onready var block_1: RigidBody3D = $"."
@onready var area_3d: Area3D = $Area3D
var speed = 2
var health = 1
@onready var player: Player = $"../../Player"
@onready var hit_sfx: AudioStreamPlayer3D = $"../../HitSfx"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += transform.basis * Vector3(0, 0, speed) * delta
	position.y = 0
	if health <= 0:
		die()

func _on_area_3d_area_entered(area: Area3D) -> void:
	#var timer = Timer.new()
	#timer.wait_time = 5.0
	#timer.start()
	#print(timer.time_left)
	hit_sfx.play()
	health -= 1
	player.score += 1
	
	#await timer.timeout
	#queue_free()
func die():
	#queue_free()
	pass
