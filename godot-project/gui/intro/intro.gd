extends VideoPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("/root/globals").stop_music()
	

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		_on_intro_finished()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_intro_finished():
	get_node("/root/globals").play_music("main")
	get_tree().change_scene("res://gameplay/main_stable/main_stable.tscn")
