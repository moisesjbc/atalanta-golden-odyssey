extends Node2D

var enemy_scene = preload("res://gameplay/Enemy/Enemy1.tscn")

var remaining_enemies = 20

signal enemy_died
signal all_enemies_died


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func start_wave(total_enemies):
	remaining_enemies = total_enemies
	$respawn_timer.start(1)


func _on_respawn_timer_timeout():
	var enemy = enemy_scene.instance()
	randomize()
	$path_2d/path_follow.set_offset(randi())
	enemy.global_position = $path_2d/path_follow.global_position
	enemy.connect("enemy_died", self, "emit_enemy_died")
	$enemies.add_child(enemy)

	remaining_enemies -= 1
	if remaining_enemies <= 0:
		$respawn_timer.stop()


func emit_enemy_died():
	emit_signal("enemy_died")
	if remaining_enemies <= 0 and $enemies.get_child_count() <= 1:
		emit_signal("all_enemies_died")
