extends Area2D

func _on_detect_player_body_entered(_body):
	$anim.play("attack")
	yield ($anim,"animation_finished")
