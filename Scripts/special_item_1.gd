extends RigidBody3D

var speed = 0.1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#position += transform.basis * Vector3(0, -speed, 0) * delta
	pass
