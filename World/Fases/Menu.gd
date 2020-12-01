extends Sprite

func _ready():
	$anim.play("start")
	yield ($anim,"animation_finished")
	$anim.play("cicle")

func _process(delta):
	if Input.is_action_just_pressed("jump"):
		$anim.play("finish")
		yield($anim,"animation_finished")
		if PlayerSheet.tutorial_01:
			get_tree().change_scene("res://World/Fases/Fase_01.tscn")
		else:
			get_tree().change_scene("res://World/Fases/Tutorial_01.tscn")
			PlayerSheet.tutorial_01 = true
