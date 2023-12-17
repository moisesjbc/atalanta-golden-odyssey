extends Node2D

var enemy_scene = preload("res://gameplay/Enemy/Enemy1.tscn")

var remaining_enemies = 20
var player
var central_object

export var skeleton_first_wave: int = 0
export var skeletons_on_first_wave: int = 2
export var new_skeletons_per_wave: int = 1
export var skeleton_movement_speed: int = 500
export var skeleton_attack_speed: float = 1
export var skeleton_damage: float = 5
export var skeleton_life: float = 3
export var ghost_first_wave: int = 1
export var ghosts_on_first_wave: int = 1
export var new_ghosts_per_wave: int = 1
export var ghost_movement_speed: int = 500
export var ghost_attack_speed: float = 1
export var ghost_damage: float = 5
export var ghost_life: float = 3
export var crow_first_wave: int = 2
export var crows_on_first_wave: int = 1
export var new_crows_per_wave: int = 1
export var crow_movement_speed: int = 500
export var crow_attack_speed: float = 1
export var crow_damage: float = 5
export var crow_life: float = 3
export var ciclop_first_wave: int = 3
export var ciclops_on_first_wave: int = 1
export var new_ciclops_per_wave: int = 1
export var ciclop_movement_speed: int = 500
export var ciclop_attack_speed: float = 1
export var ciclop_damage: float = 5
export var ciclop_life: float = 3

var enemies_defs = [
	{
		"first_wave": skeleton_first_wave,
		"enemies_on_first_wave": skeletons_on_first_wave,
		"new_enemies_per_wave": new_skeletons_per_wave,
		"movement_speed": skeleton_movement_speed,
		"attack_speed": skeleton_attack_speed,
		"damage": skeleton_damage,
		"life": skeleton_life
	},
	{
		"first_wave": ghost_first_wave,
		"enemies_on_first_wave": ghosts_on_first_wave,
		"new_enemies_per_wave": new_ghosts_per_wave,
		"movement_speed": ghost_movement_speed,
		"attack_speed": ghost_attack_speed,
		"damage": ghost_damage,
		"life": ghost_life
	},
	{
		"first_wave": crow_first_wave,
		"enemies_on_first_wave": crows_on_first_wave,
		"new_enemies_per_wave": new_crows_per_wave,
		"movement_speed": crow_movement_speed,
		"attack_speed": crow_attack_speed,
		"damage": crow_damage,
		"life": crow_life
	},
	{
		"first_wave": ciclop_first_wave,
		"enemies_on_first_wave": ciclops_on_first_wave,
		"new_enemies_per_wave": new_ciclops_per_wave,
		"movement_speed": ciclop_movement_speed,
		"attack_speed": ciclop_attack_speed,
		"damage": ciclop_damage,
		"life": ciclop_life
	}
]

var remaining_enemies_per_type = []
var total_enemies = 0

signal enemy_died
signal all_enemies_died


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_targets(player, central_object):
	self.player = player
	self.central_object = central_object


func start_wave(wave_index):
	remaining_enemies_per_type = []
	total_enemies = 0
	for i in range(0, len(enemies_defs)):
		var enemy_def = enemies_defs[i]
		if wave_index >= enemy_def["first_wave"]:
			remaining_enemies_per_type.push_back(
				enemy_def["enemies_on_first_wave"] + (wave_index - enemy_def["first_wave"]) * enemy_def["new_enemies_per_wave"]
			)
			total_enemies += remaining_enemies_per_type.back()
	
	remaining_enemies = total_enemies
	$respawn_timer.start(1)


func _on_respawn_timer_timeout():
	var enemy = enemy_scene.instance()
	randomize()
	$path_2d/path_follow.set_offset(randi())
	enemy.global_position = $path_2d/path_follow.global_position
	enemy.connect("enemy_died", self, "emit_enemy_died")
	var enemy_index = randi() % len(remaining_enemies_per_type)
	while remaining_enemies_per_type[enemy_index] == 0:
		enemy_index = (enemy_index + 1) % len(remaining_enemies_per_type)

	remaining_enemies_per_type[enemy_index] -= 1
	remaining_enemies -= 1
	if remaining_enemies <= 0:
		$respawn_timer.stop()
		
	var enemy_def = enemies_defs[enemy_index]
	enemy.init(
		enemy_index,
		player,
		central_object,
		enemy_def["movement_speed"],
		enemy_def["attack_speed"],
		enemy_def["life"],
		enemy_def["damage"]
	)
	
	$enemies.add_child(enemy)


func emit_enemy_died():
	emit_signal("enemy_died")
	if remaining_enemies <= 0 and $enemies.get_child_count() <= 1:
		emit_signal("all_enemies_died")
