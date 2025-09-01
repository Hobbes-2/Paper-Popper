extends CharacterBody3D

var speed = 5

@onready var Bullet: Area3D = $Bullet
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	position += transform.basis * Vector3(0, 0, speed) * delta
	if position.z < -24:
		queue_free()

func _on_bullet_area_entered(area: Area3D) -> void:
	frameFreeze(0.05, 0.4)
	await get_tree().create_timer(0.1 * 0.3).timeout
	Engine.time_scale = 1.0
	#queue_free()

func frameFreeze(timeScale, duration):
	Engine.time_scale = timeScale
