extends Node

var top_limit = -10*94
var right_limit = 10*94
var left_limit = -94
var bot_limit = 7*94

var player_dialog = ["maybe you need to shoot that guy"]

func _ready():
	music()

func music():
	$music.play()
	yield($music,"finished")
	music()
