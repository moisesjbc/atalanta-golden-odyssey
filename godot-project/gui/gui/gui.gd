extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	$gui/game_over_container.visible = false
	get_tree().paused = false
	$gui/health_bar.value = 100


func _on_central_object_hp_changed(new_hp):
	$gui/health_bar.value = new_hp


func _on_resume_game_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://gameplay/main_stable/main_stable.tscn")


func _on_central_object_destroyed():
	$gui/game_over_container.visible = true
	get_tree().paused = true
