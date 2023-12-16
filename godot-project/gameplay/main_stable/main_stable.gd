extends Node2D


export var initial_enemies: int = 10
export var new_enemies_per_level: int = 5
export var hp_delta_per_improvement: int = 10
export var initial_shooting_speed: float = 1.0
export var shooting_speed_delta_per_improvement: float = 0.1
export var initial_damage: int = 1
export var damage_delta_per_improvement: int = 1
var current_wave = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	$player.set_shooting_speed(initial_shooting_speed)
	$player.set_damage(initial_damage)
	start_wave(0)


func start_wave(wave_index):
	print("Start wave ", wave_index)
	print("HP ", $central_object.current_health)
	print("Shooting speed ", $player.cooldown)
	print("Damage ", $player.damage)
	current_wave = wave_index
	var total_enemies = initial_enemies + wave_index * new_enemies_per_level
	$enemy_manager.start_wave(total_enemies)
	$gui.set_total_enemies(total_enemies)


func _on_enemy_manager_all_enemies_died():
	$gui.show_improvements_panel()


func _on_gui_improvement_selected(improvement_id):
	if improvement_id == "more_hp":
		$central_object.increase_hp(hp_delta_per_improvement)
	elif improvement_id == "more_shooting_speed":
		$player.increase_shooting_speed(shooting_speed_delta_per_improvement)
	elif improvement_id == "more_damage":
		$player.increase_damage(damage_delta_per_improvement)
	start_wave(current_wave + 1)
