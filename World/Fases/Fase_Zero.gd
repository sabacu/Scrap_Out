extends Node2D

var top_limit = -94
var right_limit = 47*94
var left_limit = -94
var bot_limit = 7*94

var next_fase = "res://World/Fases/Fase_01.tscn"

var pre_spaw = preload("res://World/FX/Spawn_FX.tscn")
var pre_headless = preload("res://Chars/Player/Player_Headless.tscn")
var pre_player = preload("res://Chars/Player/Player.tscn")

var player_legs = false
var player_full = false

var dialog1 = [
	"hey, little vacuum cleaner, be careful",
	"this is a big and dangerous scrapyard",
	"be quiet here and be safe"
]

var dialog2 = [
	"look at this, the little one wants to be an adventurer",
	"ha ha ha ha ha ha ha",
	"do yourself a favor and save your battery"
]

var dialog3 = [
	"nobody ever left the scrapyard",
	"the big brother set up guards with the scraps",
	"they will take your parts and make new guards"
]

var player_dialog =[
	"now i am complete, let's leave this place"
]

func _ready():
	music()
	if PlayerSheet.tutorial_02:
		next_fase = "res://World/Fases/Fase_01.tscn"
	else:
		next_fase = "res://World/Fases/Tutorial_02.tscn"
		PlayerSheet.tutorial_02 = true

func _on_legs_body_entered(body):
	var spawn = pre_spaw.instance()
	var headless = pre_headless.instance()
	$Chars.add_child(headless)
	$Chars.add_child(spawn)
	headless.position = body.position
	spawn.position = body.position
	$Chars/body_legs.queue_free()
	$Chars/Player_zero.queue_free()

func _on_head_body_entered(body):
	var spawn = pre_spaw.instance()
	var player = pre_player.instance()
	$Chars.add_child(player)
	$Chars.add_child(spawn)
	player.position = body.position
	spawn.position = body.position
	$Chars/body_head.queue_free()
	$Chars/Player.queue_free()

func music():
	$music.play()
	yield($music,"finished")
	music()
