extends KinematicBody2D

export var speed: int = 500
onready var bullet_scene = preload("res://gameplay/bullet/bullet.tscn")
export var cooldown = 0.3
var damage

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity: Vector2 = Vector2.ZERO

	if Input.is_action_pressed("ui_left"):
		velocity.x = -1
	elif Input.is_action_pressed("ui_right"):
		velocity.x = 1

	if Input.is_action_pressed("ui_up"):
		velocity.y = -1
	elif Input.is_action_pressed("ui_down"):
		velocity.y = 1
		
	$bow.look_at(get_global_mouse_position())
	$animated_sprite.flip_h = get_global_mouse_position().x < global_position.x

	if $cooldown_timer.is_stopped() and Input.is_mouse_button_pressed(BUTTON_LEFT):
		$cooldown_timer.start(cooldown)
		var bullet = bullet_scene.instance()
		bullet.global_position = global_position
		bullet.target_position = get_global_mouse_position()
		bullet.damage = damage
		get_parent().add_child(bullet)
		$arrow.play()

	move_and_collide(speed * velocity * delta)


func set_shooting_speed(new_cooldown):
	cooldown = new_cooldown

func increase_shooting_speed(cooldown_delta):
	cooldown -= cooldown_delta

func set_damage(new_damage):
	damage = new_damage

func increase_damage(damage_delta):
	damage += damage_delta
