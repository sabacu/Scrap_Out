extends StaticBody2D

func _ready():
	$anim.play("start")
	yield($anim,"animation_finished")
	queue_free()
