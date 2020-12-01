extends CanvasLayer

var menu_open = false

func _ready():
	get_parent().get_node("Chars/Player").connect("energy_changed",self,"_on_energy_changed")
	get_parent().get_node("Chars/Player").connect("energy_head_changed",self,"_on_energy_head_changed")
	get_parent().get_node("Chars/Player").connect("energy_bullet_changed",self,"_on_energy_bullet_changed")
	get_parent().get_node("Chars/Player").connect("energy_shield_changed",self,"_on_energy_shield_changed")
	$"/root/PlayerSheet".connect("maximum_upgrade",self,"_on_maximum_upgrade")
	$"/root/PlayerSheet".connect("upgrade_did",self,"_on_upgraded")
	$"/root/PlayerSheet".connect("gain_energy",self,"_on_gain_energy")
	$"/root/PlayerSheet".connect("gain_scrap",self,"_on_gain_scrap")
	$Pause.visible = false

func _process(_delta):
	display_texts()
	render_shield()
	
	if Input.is_action_just_pressed("menu"):
		pause()
		if not menu_open:
			$Pause/anim_panel.play("start")
			$Pause.visible = true
			menu_open = true
		else:
			$Pause.visible = false
			menu_open = false
	
	if Input.is_action_just_pressed("head"):
		add_head_energy()
	
	if Input.is_action_just_pressed("bullet"):
		add_bullet_energy()
	
	if Input.is_action_just_pressed("shield"):
		add_shield_energy()

func render_shield():
	if PlayerSheet.shield_energy > 0:
		PlayerSheet.acvite_shield = true
	else:
		PlayerSheet.acvite_shield = false

func display_texts():
	$HUX/VBoxContainer/Energy_Panel/energy.text = str(PlayerSheet.energy)
	$HUX/VBoxContainer/Energy_Panel/max_energy.text = str(PlayerSheet.max_energy)
	$HUX/VBoxContainer/Head_Panel/energy.text = str(PlayerSheet.head_energy)
	$HUX/VBoxContainer/Head_Panel/max_energy.text = str(PlayerSheet.max_head_energy)
	$HUX/VBoxContainer/Bullet_Panel/energy.text = str(PlayerSheet.bullet_energy)
	$HUX/VBoxContainer/Bullet_Panel/max_energy.text = str(PlayerSheet.max_bullet_energy)
	$HUX/VBoxContainer/Shield_Panel/energy.text = str(PlayerSheet.shield_energy)
	$Pause/Panel_on/energy/total_energy/Label.text = str(PlayerSheet.energy)
	$Pause/Panel_on/energy/head/display/Label.text = str(PlayerSheet.head_energy)
	$Pause/Panel_on/energy/shield/display/Label.text = str(PlayerSheet.shield_energy)
	$Pause/Panel_on/energy/bullets/display/Label.text = str(PlayerSheet.bullet_energy)
	$Pause/Panel_on/upgrades/upgrades_button/jump_force/cost_jump_force.text = str(PlayerSheet.cost_jump)
	$Pause/Panel_on/upgrades/upgrades_button/max_energy/cost_max_energy.text = str(PlayerSheet.cost_energy)
	$Pause/Panel_on/upgrades/upgrades_button/rocket_reach/cost_rocket_reach.text = str(PlayerSheet.cost_head)
	$Pause/Panel_on/upgrades/upgrades_button/shield_force/cost_shield_force.text = str(PlayerSheet.cost_shield)
	$Pause/Panel_on/upgrades/upgrades_button/shoot_force/cost_shoot_force.text = str(PlayerSheet.cost_bullet)
	$Pause/Panel_on/upgrades/Sprite/scrap_value.text = str(PlayerSheet.scrap_parts)
	$HUX/Scrap_panel/scrap_label.text = str(PlayerSheet.scrap_parts)

func pause():
	var new_pause_state = not get_tree().paused
	get_tree().paused = new_pause_state

func add_head_energy():
	var destiny = PlayerSheet.head_energy
	var limit = PlayerSheet.max_head_energy
	if limit > destiny and PlayerSheet.energy > 0:
		$audio_controller/plus_point.play()
		PlayerSheet.energy -= 1
		PlayerSheet.head_energy += 1
	else:
		$audio_controller/error.play()
		$HUX/anim.play("head_energy")

func add_bullet_energy():
	var destiny = PlayerSheet.bullet_energy
	var limit = PlayerSheet.max_bullet_energy
	if limit > destiny and PlayerSheet.energy > 0:
		$audio_controller/plus_point.play()
		PlayerSheet.energy -= 1
		PlayerSheet.bullet_energy += 1
	else:
		$audio_controller/error.play()
		$HUX/anim.play("bullet_energy")

func add_shield_energy():
	var destiny = PlayerSheet.shield_energy
	var limit = PlayerSheet.max_shield_energy
	if limit > destiny and PlayerSheet.energy > 0:
		$audio_controller/plus_point.play()
		PlayerSheet.energy -= 1
		PlayerSheet.shield_energy += 1
		PlayerSheet.acvite_shield = true
	else:
		$audio_controller/error.play()
		$HUX/anim.play("shield_animation")

func release_head_energy():
	var destiny = PlayerSheet.head_energy
	if destiny > 0 and PlayerSheet.energy < PlayerSheet.max_energy:
		$audio_controller/minus_point.play()
		PlayerSheet.energy += 1
		PlayerSheet.head_energy -= 1
	else:
		$audio_controller/error.play()
		$HUX/anim.play("head_energy")

func release_bullet_energy():
	var destiny = PlayerSheet.bullet_energy
	if destiny > 0 and PlayerSheet.energy < PlayerSheet.max_energy:
		$audio_controller/minus_point.play()
		PlayerSheet.energy += 1
		PlayerSheet.bullet_energy -= 1
	else:
		$audio_controller/error.play()
		$HUX/anim.play("bullet_energy")

func release_shield_energy():
	var destiny = PlayerSheet.shield_energy
	if destiny > 0 and PlayerSheet.energy < PlayerSheet.max_energy:
		$audio_controller/minus_point.play()
		PlayerSheet.energy += 1
		PlayerSheet.shield_energy -= 1
	else:
		$audio_controller/error.play()
		$HUX/anim.play("shield_animation")

func _on_energy_changed():
	$HUX/anim.play("energy_changed")
	$audio_controller/energy_change.play()

func _on_gain_energy():
	$HUX/anim.play("energy_changed")

func _on_gain_scrap():
	$HUX/anim.play("scrap_gain")

func _on_maximum_upgrade():
	$audio_controller/error.play()

func _on_upgraded():
	$audio_controller/upgrade.play()

func _on_energy_head_changed():
	$HUX/anim.play("head_energy")

func _on_energy_bullet_changed():
	$HUX/anim.play("bullet_energy")

func _on_energy_shield_changed():
	$HUX/anim.play("shield_animation")

func _on_plus_head_button_down():
	add_head_energy()
	$Pause/Panel_on/energy/head/Plus.texture = preload("res://Interface/buttom_plus_down.png")

func _on_plus_head_button_up():
	$Pause/Panel_on/energy/head/Plus.texture = preload("res://Interface/buttom_plus_up.png")

func _on_minus_head_button_down():
	release_head_energy()
	$Pause/Panel_on/energy/head/Minus.texture = preload("res://Interface/buttom_minus_down.png")

func _on_minus_head_button_up():
	$Pause/Panel_on/energy/head/Minus.texture = preload("res://Interface/buttom_minus_up.png")

func _on_minus_bullet_button_down():
	release_bullet_energy()
	$Pause/Panel_on/energy/bullets/Minus.texture = preload("res://Interface/buttom_minus_down.png")

func _on_minus_bullet_button_up():
	$Pause/Panel_on/energy/bullets/Minus.texture = preload("res://Interface/buttom_minus_up.png")

func _on_plus_bullet_button_down():
	add_bullet_energy()
	$Pause/Panel_on/energy/bullets/Plus.texture = preload("res://Interface/buttom_plus_down.png")

func _on_plus_bullet_button_up():
	$Pause/Panel_on/energy/bullets/Plus.texture = preload("res://Interface/buttom_plus_up.png")

func _on_minus_shield_button_down():
	release_shield_energy()
	$Pause/Panel_on/energy/shield/Minus.texture = preload("res://Interface/buttom_minus_down.png")

func _on_minus_shield_button_up():
	$Pause/Panel_on/energy/shield/Minus.texture = preload("res://Interface/buttom_minus_up.png")

func _on_plus_shield_button_down():
	add_shield_energy()
	$Pause/Panel_on/energy/shield/Plus.texture = preload("res://Interface/buttom_plus_down.png")

func _on_plus_shield_button_up():
	$Pause/Panel_on/energy/shield/Plus.texture = preload("res://Interface/buttom_plus_up.png")

func _on_up_energy_button_down():
	PlayerSheet._buy_energy()
	$Pause/Panel_on/upgrades/upgrades_button/max_energy.texture = preload("res://Interface/buttom_upgrade2.png")

func _on_up_energy_button_up():
	$Pause/Panel_on/upgrades/upgrades_button/max_energy.texture = preload("res://Interface/buttom_upgrade1.png")

func _on_up_jump_button_down():
	PlayerSheet._buy_jump()
	$Pause/Panel_on/upgrades/upgrades_button/jump_force.texture = preload("res://Interface/buttom_upgrade2.png")

func _on_up_jump_button_up():
	$Pause/Panel_on/upgrades/upgrades_button/jump_force.texture = preload("res://Interface/buttom_upgrade1.png")

func _on_up_head_button_down():
	PlayerSheet._buy_rocket()
	$Pause/Panel_on/upgrades/upgrades_button/rocket_reach.texture = preload("res://Interface/buttom_upgrade2.png")

func _on_up_head_button_up():
	$Pause/Panel_on/upgrades/upgrades_button/rocket_reach.texture = preload("res://Interface/buttom_upgrade1.png")

func _on_up_shoot_button_down():
	PlayerSheet._buy_shoot()
	$Pause/Panel_on/upgrades/upgrades_button/shoot_force.texture = preload("res://Interface/buttom_upgrade2.png")

func _on_up_shoot_button_up():
	$Pause/Panel_on/upgrades/upgrades_button/shoot_force.texture = preload("res://Interface/buttom_upgrade1.png")

func _on_up_shield_button_down():
	PlayerSheet._buy_shield()
	$Pause/Panel_on/upgrades/upgrades_button/shield_force.texture = preload("res://Interface/buttom_upgrade2.png")

func _on_up_shield_button_up():
	$Pause/Panel_on/upgrades/upgrades_button/shield_force.texture = preload("res://Interface/buttom_upgrade1.png")


func _on_Button_pressed():
	get_tree().reload_current_scene()
	PlayerSheet.energy = 0
	PlayerSheet.head_energy = 0
	PlayerSheet.bullet_energy = 0
	PlayerSheet.shield_energy = 0
	pause()

func _on_Button2_pressed():
	get_tree().change_scene("res://World/Fases/tela_inicial.tscn")
	PlayerSheet.energy = 0
	PlayerSheet.head_energy = 0
	PlayerSheet.bullet_energy = 0
	PlayerSheet.shield_energy = 0
	PlayerSheet.max_energy = 8
	PlayerSheet.max_head_energy = 3
	PlayerSheet.max_bullet_energy = 3
	PlayerSheet.max_shield_energy = 3
	pause()
