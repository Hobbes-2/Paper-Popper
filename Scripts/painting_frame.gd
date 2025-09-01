extends Node3D


@export var Painting : Resource

@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D

func _process(delta: float) -> void:
	mesh_instance_3d.material_override.albedo_texture = Painting
