extends TextureButton


export var text: String

# Called when the node enters the scene tree for the first time.
func _ready():
	$label.text = text
