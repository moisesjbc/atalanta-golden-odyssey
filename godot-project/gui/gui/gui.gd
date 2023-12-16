extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	$gui/health_bar.value = 100


func _on_central_object_hp_changed(new_hp):
	$gui/health_bar.value = new_hp

func _on_central_object_destroyed():
	get_tree().change_scene("res://gameplay/dead_screen/DeadScreen.tscn")
