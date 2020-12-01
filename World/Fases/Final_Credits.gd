extends ColorRect

func _ready():
	$Timer2.wait_time = 5
	$Timer2.start()

func _on_Timer_timeout():
	get_tree().change_scene("res://World/Fases/tela_inicial.tscn")

func _on_Timer2_timeout():
	$tip1.visible = false
	$tip2.visible = true
	$Timer.wait_time = 5
	$Timer.start()
