extends KinematicBody2D

export var speed: int = 500

var targetposition = Vector2(960,540)
var central_object
var health = 3
signal enemy_died
var attacking = false

func _ready():
	$animated_sprite.play("walking")

# Called when the node enters the scene tree for the first time.
func _process(delta):
	var direction = (targetposition - global_position).normalized()
	
	var collition = move_and_collide(speed * direction * delta)
	if not attacking and collition:
		central_object = collition.collider
		attacking = true
		$Timer.start(1)

func _on_Timer_timeout():
	if is_instance_valid(central_object):
		$animated_sprite.play("attacking")
		$Timer.start(1)
	else:
		$Timer.stop()

func apply_damage(damage):
	print("APPLYING DAMAGE")
	health -= damage
	if health <= 0:
		enemy_die()
	else:
		$animated_sprite.play("hurt")

func enemy_die():
	$Timer.stop()
	$animated_sprite.play("dying")


func _on_animated_sprite_animation_finished():
	print("Finished ", $animated_sprite.animation)
	if $animated_sprite.animation == "attacking":
		central_object.take_damage(10.0)
		$animated_sprite.play("idle")
	elif $animated_sprite.animation == "dying":
		print("Dying!")
		emit_signal("enemy_died")
		queue_free()
	elif $animated_sprite.animation == "hurt":
		if central_object:
			$animated_sprite.play("idle")
		else:
			$animated_sprite.play("walking")
		
