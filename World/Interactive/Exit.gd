extends Area2D

func _on_Exit_body_entered(_body):
	var main_node = get_tree().current_scene
	get_tree().change_scene(main_node.next_fase)
