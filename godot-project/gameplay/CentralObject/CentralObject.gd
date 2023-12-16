extends Node2D

export var max_health: float = 100.0
var current_health: float = max_health

# onready var health_bar: TextureProgress = $HealthBar  # Asigna la barra de vida desde el editor

# Función para reducir la salud del objeto central
func take_damage(amount: float):
	current_health -= amount
	current_health = clamp(current_health, 0.0, max_health)  # Asegurarse de que la salud no sea menor que 0 ni mayor que max_health
	print(current_health)
	update_health_bar()

# Función para actualizar la barra de vida# Función para actualizar la barra de vida
func update_health_bar():
	#health_bar.value = current_health
	if current_health <= 0:
		queue_free()  # Destruir el objeto central si la salud llega a cero
