extends ColorRect

func _ready():
	$AnimationPlayer.play("start")
	yield($AnimationPlayer,"animation_finished")
	get_tree().change_scene("res://World/Fases/tela_inicial.tscn")
