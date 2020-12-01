extends KinematicBody2D

var max_speed = 70
var move_direction = 1
var velocity = Vector2.ZERO
var player = null
var dead = false
var motion = Vector2.ZERO

export var health = 2

var pre_energy = preload("res://World/Interactive/Collect/Energy.tscn")
var pre_scrap = preload("res://World/Interactive/Collect/Scrap.tscn")
var pre_spawn = preload("res://World/FX/Spawn_FX.tscn")

func _physics_process(_delta):
	
	if dead:
		motion.y = PlayerSheet.jump_force/2
		motion.x = 0
		motion = move_and_slide(motion,Vector2.UP)
		return
	
	if health <= 0 and not dead:
		die()
	
	velocity = Vector2.ZERO
	change_orientation()
	if player and not dead:
		$anim.play("patrol")
		velocity = position.direction_to(player.position) * max_speed
	elif not dead:
		$anim.play("idle")
		velocity = Vector2.ZERO
	
	velocity = move_and_slide(velocity)

func change_orientation():
	$orientation.scale.x = move_direction
	if player and player.position.x > global_position.x:
		move_direction = -1
	else:
		move_direction = 1

func _on_detect_player_body_entered(body):
	player = body

func _on_detect_player_body_exited(_body):
	player = null

func damage():
	health -= PlayerSheet.shoot_damage

func die():
	$anim.play("die")
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
	yield($anim,"animation_finished")
	queue_free()

func _on_hurtbox_area_entered(_area):
	damage()
