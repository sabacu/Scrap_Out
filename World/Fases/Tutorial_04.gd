extends ColorRect

func _ready():
	$Timer.wait_time = 8
	$Timer.start()

func _on_Timer_timeout():
	get_tree().change_scene("res://World/Fases/Fase_04.tscn")
