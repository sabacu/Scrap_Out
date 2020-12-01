extends KinematicBody2D

var target_fps = 60
var friction = 10
var air_resistance = 1
var gravity = 10
var acceleration = 15
var max_speed = 90

var motion = Vector2.ZERO
var can_move = true

var dialog_index = PlayerSheet.dialog_index
var dialog_finished = false

func _ready():
	dialog_finished = false
	var main_node = get_tree().current_scene
	$player_cam.limit_top = main_node.top_limit
	$player_cam.limit_left = main_node.left_limit
	$player_cam.limit_right = main_node.right_limit
	$player_cam.limit_bottom = main_node.bot_limit

func _physics_process(delta):
	var x_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	if x_input != 0:
		motion.x += x_input * acceleration * delta * target_fps
		motion.x = clamp(motion.x, -max_speed, max_speed)
		$sprite.flip_h = x_input < 0
		$anim.play("walk")
	else:
		$anim.play("idle")
	
	motion.y += gravity * delta * target_fps
	
	if x_input == 0:
		$anim.play("idle")
		motion.x = lerp(motion.x, 0, friction * delta)
	motion = move_and_slide(motion,Vector2.UP)
