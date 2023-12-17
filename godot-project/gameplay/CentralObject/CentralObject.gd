extends StaticBody2D

signal hp_changed
signal destroyed

export var max_health: float = 100.0
var current_health: float = max_health

func _ready():
	$apple_sprite.play("idle")


# Función para reducir la salud del objeto central
func take_damage(amount: float):
	$apple_sprite.play("hurt")
	modify_hp(-amount)


func increase_hp(amount: float):
	modify_hp(amount)


func modify_hp(hp_delta):
	current_health += hp_delta
	current_health = clamp(current_health, 0.0, max_health)  # Asegurarse de que la salud no sea menor que 0 ni mayor que max_health
	emit_signal("hp_changed", current_health)
	if current_health <= 0:
		emit_signal("destroyed")
		queue_free()  # Destruir el objeto central si la salud llega a cero


func _on_apple_sprite_animation_finished():
	if $apple_sprite.animation == "hurt":
		$apple_sprite.play("idle")
		
