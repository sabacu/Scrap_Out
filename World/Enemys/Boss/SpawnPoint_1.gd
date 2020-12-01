extends Position2D

var pre_enemy = preload("res://World/Enemys/Boss/Boss_Ball.tscn")
var pre_spawn = preload("res://World/FX/Spawn_FX.tscn")

func _ready():
	$Timer.wait_time = rand_range(5,20)
	$Timer.start()

func _on_Timer_timeout():
	var enemy = pre_enemy.instance()
	var spawn = pre_spawn.instance()
	var main_node = get_tree().current_scene
	main_node.add_child(enemy)
	main_node.add_child(spawn)
	enemy.position = position
	spawn.position = position
	$Timer.wait_time = rand_range(5,20)
	$Timer.start()
