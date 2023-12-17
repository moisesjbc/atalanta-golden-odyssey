extends Node2D


func _ready():
	OS.window_fullscreen = true


func _on_return_to_main_menu_pressed():
	get_tree().change_scene("res://intr")


func _on_credits_pressed():
	get_tree().change_scene("res://gui/credits_menu/credits_menu.tscn")


func _on_play_pressed():
	get_tree().change_scene("res://gui/intro/intro.tscn")
