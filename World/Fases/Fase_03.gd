extends Node

var top_limit = -117*94
var right_limit = 29*94
var left_limit = -94
var bot_limit = 7*94

var next_fase = "res://World/Fases/Tutorial_04.tscn"

var dialog1 = [
	"many automakers will try to prevent you from leaving",
	"if you beat them maybe you can take some energy or scrap",
	"different enemies behave in different ways, be careful"
]

var dialog2 = [
	"try to collect as much scrap",
	"upgrades can be important for the future challenges"
]

var dialog3 = [
	"be sure to make your upgrades",
	"choose them wisely"
]

var player_dialog = [
	"maybe you need to shoot that guy",
	"where can i find a infinite stone?",
	"why so serious?",
	"boys don't cry",
	"run run run run",
	"maybe that's really not a good idea"
]


func _ready():
	music()

func music():
	$music.play()
	yield($music,"finished")
	music()
