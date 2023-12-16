extends KinematicBody2D

export var speed: int = 500

var targetposition = Vector2(960,540)

# Called when the node enters the scene tree for the first time.
func _process(delta):

	var direction = (targetposition - global_position).normalized()
	
	move_and_collide(speed * direction * delta)
