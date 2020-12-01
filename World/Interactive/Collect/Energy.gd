extends StaticBody2D

func _on_colide_body_entered(_body):
	if PlayerSheet.energy < PlayerSheet.max_energy:
		PlayerSheet.emit_signal("gain_energy")
		PlayerSheet.energy += 1
		$collect.play()
		yield($collect,"finished")
		queue_free()
	else:
		$error.play()
		PlayerSheet.emit_signal("gain_energy")
