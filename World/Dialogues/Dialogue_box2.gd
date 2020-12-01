extends Area2D

var dialog_index = 0
var dialog_open = false
var dialog_finished = false

var dialog = []

func _ready():
	var main_node = get_tree().current_scene
	dialog = main_node.dialog2

func start_dialog():
	if not dialog_finished:
		dialog_open = true
		if dialog_index == 0:
			load_dialog()
			$anim.play("start")
			yield($anim,"animation_finished")
		elif dialog_index != 0:
			load_dialog()

func load_dialog():
	if dialog_index < dialog.size():
		$dialogue.text = dialog[dialog_index]
		dialog_index += 1
		$next.wait_time = 5
		$next.start()
	else:
		dialog_finished = true
		$anim.play_backwards("start")
		$next.stop()

func _on_next_timeout():
	start_dialog()

func _on_Dialogue_box_body_entered(_body):
	if not dialog_open:
		start_dialog()
