extends KinematicBody2D

export var speed: int = 500

var targetposition = Vector2(960,540)
var central_object
# Called when the node enters the scene tree for the first time.
func _process(delta):

	var direction = (targetposition - global_position).normalized()
	
	var collition = move_and_collide(speed * direction * delta)
	if $Timer.is_stopped() and collition:
		central_object = collition.collider
		$Timer.start(1)


func _on_Timer_timeout():
	if central_object : central_object.take_damage(10.0)
