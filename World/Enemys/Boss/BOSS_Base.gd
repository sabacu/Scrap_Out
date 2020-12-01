extends KinematicBody2D

var Health = 30
var invencible = false

func _physics_process(delta):
	if Health <= 0:
		die()
		queue_free()

func _ready():
	$anim.play("idle_1")
	$timer_1.wait_time = rand_range(2,10)
	$timer_1.start()

func move_12():
	$anim.play("move_1_2")
	yield($anim,"animation_finished")
	$anim.play("idle_2")
	$timer_2.wait_time = rand_range(2,10)
	$timer_2.start()

func move_23():
	$anim.play("move_2_3")
	yield($anim,"animation_finished")
	$anim.play("idle_3")
	$timer_3.wait_time = rand_range(2,10)
	$timer_3.start()

func move_32():
	$anim.play("move_3_2")
	yield($anim,"animation_finished")
	$anim.play("idle_2")
	$timer_4.wait_time = rand_range(2,10)
	$timer_4.start()

func move_21():
	$anim.play("move_2_1")
	yield($anim,"animation_finished")
	$anim.play("idle_1")
	$timer_1.wait_time = rand_range(2,10)
	$timer_1.start()

func damage():
	if not invencible:
		invencible = true
		Health -= PlayerSheet.shoot_damage
		$Base/Sprite_anim.play("hurt")
		yield($Base/Sprite_anim,"animation_finished")
		$Base/Sprite_anim.play("idle")
		invencible = false

func die():
	get_tree().change_scene("res://World/Fases/Final_Credits.tscn")

func _on_timer_1_timeout():
	move_12()
	$timer_1.stop()

func _on_timer_2_timeout():
	move_23()
	$timer_2.stop()

func _on_timer_3_timeout():
	move_32()
	$timer_3.stop()

func _on_timer_4_timeout():
	move_21()
	$timer_4.stop()

func _on_HurtBox_area_entered(area):
	damage()
