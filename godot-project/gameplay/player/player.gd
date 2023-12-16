extends KinematicBody2D

export var speed: int = 500
onready var bullet_scene = preload("res://gameplay/bullet/bullet.tscn")
export var cooldown = 0.3

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

	if $cooldown_timer.is_stopped() and Input.is_mouse_button_pressed(BUTTON_LEFT):
		$cooldown_timer.start(cooldown)
		var bullet = bullet_scene.instance()
		bullet.global_position = global_position
		bullet.target_position = get_global_mouse_position()
		get_parent().add_child(bullet)

	move_and_collide(speed * velocity * delta)
