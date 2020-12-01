extends KinematicBody2D

var target_fps = 60
var friction = 10
var air_resistance = 1
var gravity = 10

var shoot_direction = 1

var motion = Vector2.ZERO
var can_move = true
var jumping = false

func _ready():
	var main_node = get_tree().current_scene
	$player_cam.limit_top = main_node.top_limit
	$player_cam.limit_left = main_node.left_limit
	$player_cam.limit_right = main_node.right_limit
	$player_cam.limit_bottom = main_node.bot_limit
	$anim_balloon.play("start")
	yield($anim_balloon,"animation_finished")
	$anim_balloon.play_backwards("start")

func _physics_process(delta):
	var x_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	if x_input != 0:
		motion.x += x_input * PlayerSheet.acceleration * delta * target_fps
		motion.x = clamp(motion.x, -PlayerSheet.max_speed, PlayerSheet.max_speed)
		$sprite.flip_h = x_input < 0
		$anim.play("walk")
		
	motion.y += gravity * delta * target_fps
	if test_move(transform,Vector2.DOWN):
		jumping = false
		if x_input == 0:
			$anim.play("idle")
			motion.x = lerp(motion.x, 0, friction * delta)
		if Input.is_action_just_pressed("jump"):
			$audio_controller/jump.play()
			$anim.play("jump")
			jumping = true
			motion.y = -PlayerSheet.jump_force
	else:
		if Input.is_action_just_released("jump") and motion.y < -PlayerSheet.jump_force/2:
			motion.y = -PlayerSheet.jump_force/2
		if x_input == 0:
			motion.x = lerp(motion.x, 0, air_resistance * delta)
	motion = move_and_slide(motion,Vector2.UP)
