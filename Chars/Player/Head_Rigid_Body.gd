extends RigidBody2D

var dragging
var drag_start = Vector2()
var texture_padrao = preload("res://art_open_files/Sprite_base.png")

var flip = false

func _ready():
	_render_shield()
	var main_node = get_tree().current_scene
	$head_cam.limit_top = main_node.top_limit
	$head_cam.limit_left = main_node.left_limit
	$head_cam.limit_right = main_node.right_limit
	$head_cam.limit_bottom = main_node.bot_limit
	$anim.play("idle")
	if PlayerSheet.acvite_shield:
		$head_shield.visible = true
	else:
		$head_shield.visible = false

func _input(event):
	
	if event.is_action_pressed("shoot"):
		reach(position)
	
	if event.is_action_pressed("click") and not dragging:
		dragging = true
		drag_start = get_global_mouse_position()
	if event.is_action_released("click") and dragging and PlayerSheet.head_energy > 0:
		get_parent().get_node("Chars/Player").emit_signal("energy_head_changed")
		$head_rocket.play()
		PlayerSheet.head_energy -= 1
		dragging = false
		var drag_end = get_global_mouse_position()
		var dir = drag_start - drag_end
		apply_impulse(Vector2.ZERO, dir * PlayerSheet.rocket_force)
		$anim.play("travel")
		yield ($anim,"animation_finished")
		$anim.play("idle")

func _render_shield():
	if PlayerSheet.max_shield_energy > 9:
		$head_shield.texture = preload("res://art_open_files/head_shield_sheet_5.png")
		return
	if PlayerSheet.max_shield_energy > 6:
		$head_shield.texture = preload("res://art_open_files/head_shield_sheet_3.png")
		return
	if PlayerSheet.max_shield_energy > 3:
		$head_shield.texture = preload("res://art_open_files/head_shield_sheet_2.png")
		return

func reach(position):
	position = self.position
	get_parent().get_node("Chars/Player").return_function(position)
	queue_free()

func _on_detect_touch_area_entered(_area):
	reach(position)
