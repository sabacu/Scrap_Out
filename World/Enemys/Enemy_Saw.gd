extends KinematicBody2D

var target_fps = 60
var acceleration = 20
var max_speed = 80
var friction = 10
var air_resistance = 1
var gravity = 10
var patrol_distance = 300

var damage = 1

var move_direction = -1

var motion = Vector2.ZERO
var can_move = true

var moving = false
var attacking = false
var wait_patrol = false
var player_in_range = false
var dead = false

export var health = 2

var pre_energy = preload("res://World/Interactive/Collect/Energy.tscn")
var pre_scrap = preload("res://World/Interactive/Collect/Scrap.tscn")
var pre_spawn = preload("res://World/FX/Spawn_FX.tscn")

func _physics_process(delta):
	
	if health <= 0 and not dead:
		die()
	
	if player_in_range and not attacking and not dead:
		attacking = true
		$patrol.wait_time = 2
		$anim.play("attack")
		yield($anim,"animation_finished")
		attacking = false
		$anim.play("idle")
		return
	
	if can_move and not attacking and not dead:
		moving = true
		motion.x += move_direction * acceleration * delta * target_fps
		motion.x = clamp(motion.x, -max_speed, max_speed)
		$anim.play("walk")
	
	elif not wait_patrol and not dead:
		move_direction = move_direction * -1
		$orientation.scale.x = $orientation.scale.x * -1
		$patrol.wait_time = rand_range(2,10)
		$patrol.start()
		$anim.play("idle")
		wait_patrol = true
	
	motion.y += gravity * delta * target_fps
	
	if test_move(transform,Vector2.DOWN):
		if not moving:
			motion.x = lerp(motion.x,0,friction*delta)
	else:
		motion.y = 300
	
	motion = move_and_slide(motion,Vector2.UP)

func damage():
	health -= PlayerSheet.shoot_damage

func die():
#	$anim.play("die")
	motion = Vector2.ZERO
	var energy = pre_energy.instance()
	var scrap = pre_scrap.instance()
	var spawn = pre_spawn.instance()
	var spawn_2 = pre_spawn.instance()
	if randf() < 0.75:
		owner.add_child(spawn)
		owner.add_child(energy)
		energy.position = position
		spawn.position = position
	if randf() < 0.75:
		owner.add_child(spawn_2)
		owner.add_child(scrap)
		scrap.position = position - Vector2(20,20)
		spawn_2.position = position - Vector2(20,20)
	dead = true
	queue_free()

func invert_patrol():
	can_move = false
	moving = false
	wait_patrol = false

func _on_detect_floor_body_exited(_body):
	invert_patrol()

func _on_patrol_timeout():
	if not attacking:
		can_move = true
	else:
		$patrol.wait_time = 2
		$patrol.start()

func _on_detect_player_body_entered(_body):
	player_in_range = true

func _on_hurtbox_area_entered(_area):
	damage()

func _on_detect_player_body_exited(_body):
	player_in_range = false

func _on_detect_wall_body_entered(_body):
	invert_patrol()
