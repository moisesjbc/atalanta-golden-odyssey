extends Node2D


export var initial_enemies: int = 10
export var new_enemies_per_level: int = 5
export var hp_delta_per_improvement: int = 10
var current_wave = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	start_wave(0)


func start_wave(wave_index):
	current_wave = wave_index
	var total_enemies = initial_enemies + wave_index * new_enemies_per_level
	$enemy_manager.start_wave(total_enemies)
	$gui.set_total_enemies(total_enemies)


func _on_enemy_manager_all_enemies_died():
	$gui.show_improvements_panel()


func _on_gui_improvement_selected(improvement_id):
	if improvement_id == "more_hp":
		$central_object.increase_hp(hp_delta_per_improvement)
	start_wave(current_wave + 1)
