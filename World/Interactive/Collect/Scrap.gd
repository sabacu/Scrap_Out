extends StaticBody2D

func _on_colide_body_entered(_body):
	PlayerSheet.emit_signal("gain_scrap")
	PlayerSheet.scrap_parts += 1
	$collect.play()
	yield($collect,"finished")
	queue_free()
