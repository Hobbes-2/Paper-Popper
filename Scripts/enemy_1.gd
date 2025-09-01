extends CharacterBody3D

var speed = 2
var Bullet = load("res://Scenes/bullet.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#var instance = bullet.instantiate()
	#real_bullet = instance.Bullet
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += transform.basis * Vector3(speed, 0, 0) * delta

func _on_area_3d_area_entered(area: Area3D) -> void:
	if area == Bullet:
		free()
		print("dead")


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body == Bullet:
		print("dead")
