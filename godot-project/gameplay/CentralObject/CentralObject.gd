extends StaticBody2D

signal hp_changed
signal destroyed

export var max_health: float = 100.0
var current_health: float = max_health

# Función para reducir la salud del objeto central
func take_damage(amount: float):
	current_health -= amount
	current_health = clamp(current_health, 0.0, max_health)  # Asegurarse de que la salud no sea menor que 0 ni mayor que max_health
	emit_signal("hp_changed", current_health)
	if current_health <= 0:
		emit_signal("destroyed")
		queue_free()  # Destruir el objeto central si la salud llega a cero
