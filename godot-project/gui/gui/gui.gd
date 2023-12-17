extends Node

var total_enemies = 0
var killed_enemies = 0
signal more_hp_selected
signal more_shooting_speed_selected
signal more_damage_selected
signal improvement_selected


# Called when the node enters the scene tree for the first time.
func _ready():
	$gui/health_bar.value = 100


func _on_central_object_hp_changed(new_hp):
	$gui/health_bar.value = new_hp


func _on_central_object_destroyed():
	get_tree().change_scene("res://gameplay/dead_screen/DeadScreen.tscn")


func set_total_enemies(total_enemies):
	self.total_enemies = total_enemies
	self.killed_enemies = 0
	update_enemies_label()


func update_enemies_label():
	$gui/enemies_label.text = "Enemies: " + str(self.killed_enemies) + " / " + str(self.total_enemies)

func set_current_wave(wave_index):
	$gui/wave_label.text = "Wave: " + str(wave_index)

func _on_enemy_manager_enemy_died():
	self.killed_enemies += 1
	update_enemies_label()


func show_improvements_panel():
	get_tree().paused = true
	$gui/improvements_panel.visible = true

func close_improvements_panel():
	get_tree().paused = false
	$gui/improvements_panel.visible = false


func _on_more_hp_button_pressed():
	emit_signal("improvement_selected", "more_hp")
	close_improvements_panel()


func _on_more_speed_button_pressed():
	emit_signal("improvement_selected", "more_shooting_speed")
	close_improvements_panel()


func _on_more_damage_button_pressed():
	emit_signal("improvement_selected", "more_damage")
	close_improvements_panel()


