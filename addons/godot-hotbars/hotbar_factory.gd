const HotbarButton = preload("res://addons/godot-hotbars/hotbar_button.tscn")
#const DragDrop = preload("res://addons/com.brandonlamb.ui.hotbars/drag_drop.gd")
const MoveButton = preload("res://addons/godot-hotbars/move_button.tscn")

const MIN_BUTTONS = 1
const MAX_BUTTONS = 10

func create(num_columns = 10, num_buttons = 10):
	"""
	Create a hotbar, add specified number of buttons
	"""
	if num_buttons < MIN_BUTTONS || num_buttons > MAX_BUTTONS:
		print("Invalid number of buttons for hotbar")
		return

	if num_columns > 1 && num_buttons > 1:
		num_columns += 1

	# Create panel container to add buttons grid container and buttons
	var container = PanelContainer.new()
#	container.set_script(DragDrop)
	container.set_name("hotbar")

	# Add move button to panel container
#	var move_button = Button.new()
#	var move_button = TextureButton.new()
	var move_button = MoveButton.instance()
	move_button.use_snap = false
	move_button.snap_size = 64

#	var t = Texture.new("res://addons/com.brandonlamb.ui.hotbars/gear.png")
#	t.set_path("res://addons/com.brandonlamb.ui.hotbars/gear.png")
#	move_button.set_normal_texture(t)

	move_button.set_name("move_button")
#	move_button.set_size(Vector2(32, 32))
#	move_button.set_text(": :")
#	move_button.set_flat(true)
#	move_button.set_toggle_mode(true)

	# Add a grid container as a child of the panel container to provide nicely
	# spaced buttons
	var buttons = GridContainer.new()
	buttons.set_name("buttons")
	buttons.set_columns(num_columns)
	buttons.add_child(move_button)
	container.add_child(buttons)

	# Add buttons to hotbar as btn_0, btn_1, etc
	for i in range(num_buttons):
		var button = HotbarButton.instance()
		button.set_name("btn_" + str(i))
		#button.set_label(str(i + 1))
		button.hotbar_text = str(i + 1)
		button.set_size(Vector2(32, 32))
		buttons.add_child(button)

	# Set size of panel container to the size of the grid container
	# as this will be used with dragging support to know the bounds of the hotbar
	container.set_size(buttons.get_size())

	move_button.get_rect().position = Vector2(0, -20)
	move_button.get_rect().size = Vector2(20, 20)
	move_button.set_size(Vector2(20, 20))
	move_button.set_position(Vector2(0, -20))

	return container
