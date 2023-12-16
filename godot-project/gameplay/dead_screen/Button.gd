extends Button

# Called when the node enters the scene tree for the first time.
func _ready():
	# Conectar la señal "pressed" a la función _on_button_pressed
	connect("pressed", self, "_on_button_pressed")

# Función llamada cuando el botón es presionado
func _on_button_pressed():
	# Cargar la escena principal
	get_tree().change_scene("res://gameplay/main_stable/main_stable.tscn")
