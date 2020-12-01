extends RigidBody2D

var pre_enemy1 = preload("res://World/Enemys//Boss/Enemy_Toast.tscn")
var pre_spawn = preload("res://World/FX/Spawn_FX.tscn")

func _on_Spawn_box_area_entered(area):
	var enemy = pre_enemy1.instance()
	var spawn = pre_spawn.instance()
	var main_node = get_tree().current_scene
	main_node.add_child(enemy)
	main_node.add_child(spawn)
	enemy.position = position
	spawn.position = position
	queue_free()
