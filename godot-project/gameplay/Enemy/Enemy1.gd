extends KinematicBody2D

export var speed: int = 500

var target
var player
var central_object
var health = 3
signal enemy_died
var attacking = false
var initial_h_scale
var animated_sprite
var movement_speed
var attack_speed
var damage


func init(selected_animation_index, player, central_object, movement_speed, attack_speed, health, damage):
	for animation_index in $animations.get_child_count():
		$animations.get_child(animation_index).visible = (animation_index == selected_animation_index)
	animated_sprite = $animations.get_child(selected_animation_index)
	animated_sprite.play("walking")
	initial_h_scale = scale.x
	
	self.player = player
	self.central_object = central_object
	self.movement_speed = movement_speed
	self.attack_speed = attack_speed
	self.health = health
	self.damage = damage


# Called when the node enters the scene tree for the first time.
func _process(delta):
	if is_instance_valid(player) and is_instance_valid(central_object):
		if global_position.distance_to(player.global_position) < global_position.distance_to(central_object.global_position):
			if target == central_object:
				attacking = false
			target = player
		else:
			if target == player:
				attacking = false
			target = central_object

	var direction = (target.global_position - global_position).normalized()

	# Enemy looks to the left by default
	if direction.x >= 0:
		animated_sprite.flip_h = true
	
	if animated_sprite.animation != "dying":
		var collition = move_and_collide(movement_speed * direction * delta)
		if not attacking and collition:
			attacking = true
			$Timer.start(attack_speed)

func _on_Timer_timeout():
	if is_instance_valid(central_object):
		animated_sprite.play("attacking")
		$Timer.start(attack_speed)
	else:
		$Timer.stop()

func apply_damage(damage):
	health -= damage
	if health <= 0:
		enemy_die()
	else:
		animated_sprite.play("hurt")

func enemy_die():
	$Timer.stop()
	$CollisionShape2D.disabled = true
	animated_sprite.play("dying")


func _on_animated_sprite_animation_finished():
	if animated_sprite.animation == "attacking":
		central_object.take_damage(10.0)
		if target == player:
			player.hurt()
		animated_sprite.play("idle")
	elif animated_sprite.animation == "dying":
		emit_signal("enemy_died")
		queue_free()
	elif animated_sprite.animation == "hurt":
		if central_object:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("walking")
		


func _on_ghost_animation_finished():
	_on_animated_sprite_animation_finished()


func _on_skeleton_animation_finished():
	_on_animated_sprite_animation_finished()


func _on_ciclop_animation_finished():
	_on_animated_sprite_animation_finished()


func _on_crow_animation_finished():
	_on_animated_sprite_animation_finished()
