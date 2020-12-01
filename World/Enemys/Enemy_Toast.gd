extends KinematicBody2D

var target_fps = 60
var acceleration = 20
var max_speed = 80
var friction = 10
var air_resistance = 1
var gravity = 10
var patrol_distance = 300

var bullet_gravity = 250
var spawn_fx = preload("res://World/FX/Spawn_FX.tscn")

export var damage_player = 1
export var health = 2
var dead = false

var move_direction = -1

var motion = Vector2.ZERO
var can_move = true

var moving = false
var attacking = false
var wait_patrol = false
var player_in_range = false

var pre_energy = preload("res://World/Interactive/Collect/Energy.tscn")
var pre_scrap = preload("res://World/Interactive/Collect/Scrap.tscn")
var pre_spawn = preload("res://World/FX/Spawn_FX.tscn")

var Bullet_1 = preload("res://World/Enemys/bullet_toaster_1.tscn")
var Bullet_2 = preload("res://World/Enemys/bullet_toaster_2.tscn")

func _physics_process(delta):
	if health <= 0 and not dead:
		die()
	
	if player_in_range and not dead:
		attack()
		return
	
	if can_move and not attacking and not dead:
		moving = true
		motion.x += move_direction * acceleration * delta * target_fps
		motion.x = clamp(motion.x, -max_speed, max_speed)
		$anim.play("walk")
	
	elif not wait_patrol and not dead:
		$anim.play("idle")
		move_direction = move_direction * -1
		$orientation.scale.x = $orientation.scale.x * -1
		$patrol.wait_time = rand_range(2,10)
		$patrol.start()
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

func attack():
	$patrol.wait_time = 2
	if not attacking:
		$anim.play("attack")
		yield($anim,"animation_finished")

func bullet():
	if move_direction < 0 and not attacking:
		attacking = true
		var bullet = Bullet_2.instance()
		var fx = spawn_fx.instance()
		owner.add_child(bullet)
		bullet.transform = $orientation/sprite/muzzle.global_transform
		owner.add_child(fx)
		fx.transform = $orientation/sprite/muzzle.global_transform
		$attack_refil.wait_time = 2
		$attack_refil.start()
	elif not attacking:
		attacking = true
		var bullet = Bullet_1.instance()
		var fx = spawn_fx.instance()
		owner.add_child(bullet)
		bullet.transform = $orientation/sprite/muzzle.global_transform
		owner.add_child(fx)
		fx.transform = $orientation/sprite/muzzle.global_transform
		$attack_refil.wait_time = 2
		$attack_refil.start()

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

func _on_detect_player_body_exited(_body):
	player_in_range = false

func _on_hurtbox_area_entered(_area):
	damage()

func _on_detect_wall_body_entered(_body):
	invert_patrol()

func _on_attack_refil_timeout():
	attacking = false
