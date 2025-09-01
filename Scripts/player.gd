extends CharacterBody3D
class_name Player
#@onready var animation_player: AnimationPlayer = $Node3D/AnimationPlayer

var speed = 2
@onready var shoot_dir: RayCast3D = $ShootDir

var bullet = preload("res://Scenes/bullet.tscn")
@onready var pos: Node3D = $Pos

#SHADER ANIMATION VARIABLES
const FRAME_TIME := 0.17
var time_accumulator :=0.0
var last_animation := ""
var animation_position := 0.0

signal Parry
@onready var Score: Label3D = $Score
var score : int = 0


func set_animation(animation_name):
	var ticks_msec = Time.get_ticks_msec()
	#if last_animation != animation_name:
		#animation_player.play(animation_name)
		#animation_player.stop()
		#last_animation = animation_name
		#animation_position = 0.0
		#time_accumulator = 0.0
	#elif time_accumulator >= FRAME_TIME:
		#animation_position += time_accumulator
		#animation_player.seek(animation_position, true)
		#animation_player.stop(true)
		#time_accumulator = float(ticks_msec % int(FRAME_TIME * 1000)) /1000

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	var direction = Vector3.ZERO
	
	var dir_z = Input.get_axis("Up", "Down")
	var dir_x = Input.get_axis("Left", "Right")
	if Input.is_action_pressed("Right"):
		set_animation("HumanM_Walk01_Left")
		direction.x += 1
	if Input.is_action_pressed("Left"):
		set_animation("HumanM_Walk01_Right")
		direction.x -= 1
	if Input.is_action_pressed("Down"):
		set_animation("HumanM_Walk01_Forward")
		direction.z += 1
	if Input.is_action_pressed("Up"):
		set_animation("HumanM_Walk01_Backward")
		direction.z -= 1

	if Input.is_action_just_pressed("AimL"):
		shoot_dir.target_position.z = 3.0
	if Input.is_action_just_pressed("AimR"):
		shoot_dir.target_position.z = -3.0
	if Input.is_action_just_pressed("AimC"):
		shoot_dir.target_position.z = 0.0
	if direction != Vector3.ZERO:
	# Ground velocity
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = 0
		velocity.z = 0
	## Vertical velocity
		#velocity.y -= fall_acceleration * delta
	# Moving the character

	move_and_slide()

	Score.text = ("Score: " + str(score))
	#print(Score.text)

	if Input.is_action_just_pressed("Shoot"):
		var instance = bullet.instantiate()
		instance.position = pos.global_position
		instance.transform.basis = pos.global_transform.basis
		get_parent().add_child(instance)

	if position.y < -25:
		get_tree().change_scene_to_file("res://Scenes/game_over.tscn")


func _on_parry_area_area_entered(area: Area3D) -> void:
	if Input.is_action_pressed("Punch"):
		var direction_of_parry = shoot_dir.target_position
		emit_signal("Parry")
		frameFreeze(0.05, 0.4)
		await get_tree().create_timer(0.1 * 0.3).timeout
		Engine.time_scale = 1.0
		#queue_free()
		print("Parried")


func frameFreeze(timeScale, duration):
	Engine.time_scale = timeScale


func _on_parry_area_body_entered(body: Node3D) -> void:
	pass
