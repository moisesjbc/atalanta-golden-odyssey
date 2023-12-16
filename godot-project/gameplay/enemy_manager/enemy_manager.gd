extends Node2D

var enemy_scene = preload("res://gameplay/Enemy/Enemy1.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_respawn_timer_timeout():
	var enemy = enemy_scene.instance()
	randomize()
	$path_2d/path_follow.set_offset(randi())
	enemy.global_position = $path_2d/path_follow.global_position
	print(" ", enemy.global_position)
	$enemies.add_child(enemy)
