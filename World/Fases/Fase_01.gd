extends Node

var top_limit = -56*94
var right_limit = 107*94
var left_limit = -94
var bot_limit = 7*94

var dialog1 = [
	"you need to choose wisely how to spend your energy",
	"it can be relocated in the menu - press enter",
	"you can take more energy if it’s not at full capacity"
]

var dialog2 = [
	"if you collect enough scrap you can improve your skills",
	"but you may need to spend more energy to reach them",
	"will it be worth it?"
]

var dialog3 = [
	"with the rocket head you can reach more distant places",
	"press Q to launch, click and drag to set force and direction",
	"at any time you can press E and switch places with the head"
]
var next_fase = "res://World/Fases/Fase_02.tscn"

var player_dialog = ["maybe more energy to shield cell",
"be or not to be",
"where is my mind?",
"you and whose army?",
"ladies and gentlemen, we're floating in space",
"are you sure you know what you are doing?",
"a jigsaw falling into place",
"are you doing it on purpose?",
"that's why humanity has failed",
"I think it was enough"]

func _ready():
	music()
	if PlayerSheet.tutorial_03:
		next_fase = "res://World/Fases/Fase_02.tscn"
	else:
		next_fase = "res://World/Fases/Tutorial_03.tscn"
		PlayerSheet.tutorial_03 = true

func music():
	$music.play()
	yield($music,"finished")
	music()
