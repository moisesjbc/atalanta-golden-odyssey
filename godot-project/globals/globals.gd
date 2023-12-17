extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	play_music("main")


func play_music(music_id):
	for music in $music.get_children():
		if music.name == music_id:
			music.play()
		else:
			music.stop()
