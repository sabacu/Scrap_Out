extends RigidBody2D

func _ready():
	$anim.play("start")
	yield($anim,"animation_finished")
	$anim.play("idle")

func contact():
	$sprite.visible = false
	$anim.play("contact")

func _on_collision_body_entered(_body):
	contact()
	$queue.wait_time = 1
	$queue.start()
	


func _on_queue_timeout():
	queue_free()
