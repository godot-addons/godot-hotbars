extends TextureButton

export(String) var hotbar_text = ""

func _ready():
	set_label(hotbar_text)

func set_label(text):
	get_node("label").set_text(text)
