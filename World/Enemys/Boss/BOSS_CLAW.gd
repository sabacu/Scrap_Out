extends KinematicBody2D

var player = null
var attacking = false
var direction = 1

func _ready():
	$anim.play("idle")

func _physics_process(delta):
	if player and not attacking:
		attack()

func attack():
	attacking = true
	$anim.play("attack")
	yield($anim,"animation_finished")
	position.x += 450 * direction
	direction = direction*-1
	$Timer.wait_time = rand_range(5,15)
	$Timer.start()

func _on_Detect_body_entered(body):
	player = body

func _on_Detect_body_exited(_body):
	player = null

func _on_Timer_timeout():
	$Timer.stop()
	$anim.play("return")
	yield($anim,"animation_finished")
	attacking = false
