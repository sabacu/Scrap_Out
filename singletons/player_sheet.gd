extends Node

var jump_force = 400
var shoot_force = 300
var shoot_damage = 1
var rocket_force = 1.5
var shield_power = 1
var acceleration = 30
var max_speed = 150

var scrap_parts = 0

var max_energy = 8
var max_head_energy = 3
var max_bullet_energy = 3
var max_shield_energy = 3

var cost_energy = 10
var cost_jump = 10
var cost_head = 10
var cost_bullet = 10
var cost_shield = 10

var energy = 0
var head_energy = 0
var bullet_energy = 0
var shield_energy = 0

var sprite_flipped = false
var acvite_shield = false

signal maximum_upgrade
signal upgrade_did
signal gain_energy
signal gain_scrap

var finish_tutorial = false

var dialog_index = 0

var tutorial_01 = false
var tutorial_02 = false
var tutorial_03 = false

func _buy_jump():
	if cost_jump <= scrap_parts and jump_force < 1000:
		scrap_parts -= cost_jump
		jump_force += 50
		cost_jump += 10
		max_speed += 25
		acceleration += 2
		emit_signal("upgrade_did")
	else:
		emit_signal("maximum_upgrade")

func _buy_energy():
	if cost_energy <= scrap_parts and max_energy < 30: 
		scrap_parts -= cost_energy
		max_energy += 1
		cost_energy += 10
		emit_signal("upgrade_did")
	else:
		emit_signal("maximum_upgrade")

func _buy_rocket():
	if rocket_force < 10 and cost_head <= scrap_parts:
		scrap_parts -= cost_head
		rocket_force += 0.5
		cost_head += 10
		max_head_energy += 1
		emit_signal("upgrade_did")
	else:
		emit_signal("maximum_upgrade")

func _buy_shoot():
	if shoot_damage < 30 and cost_bullet <= scrap_parts:
		scrap_parts -= cost_bullet
		shoot_force += 50
		shoot_damage += 0.5
		cost_bullet += 10
		max_bullet_energy += 1
		emit_signal("upgrade_did")
	else:
		emit_signal("maximum_upgrade")

func _buy_shield():
	if shield_power <= 10 and cost_shield <= scrap_parts:
		scrap_parts -= cost_shield
		shield_power += 1
		cost_shield += 10
		max_shield_energy += 1
		emit_signal("upgrade_did")
	else:
		emit_signal("maximum_upgrade")
