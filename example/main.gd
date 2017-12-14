extends Node

const HotbarFactory = preload("res://addons/godot-hotbars/hotbar_factory.gd")

func _ready():
	var hotbarFactory = HotbarFactory.new()
	var hotbars = get_node("hotbars")

	var hotbar1 = hotbarFactory.create(1, 10)
	hotbar1.set_name("hotbar_0")
	hotbar1.set_global_position(Vector2(128, 128))
	hotbars.add_child(hotbar1)

	var hotbar2 = hotbarFactory.create(1, 10)
	hotbar2.set_name("hotbar_1")
	hotbar2.set_global_position(Vector2(32, 128))
	hotbars.add_child(hotbar2)

	var hotbar3 = hotbarFactory.create(10, 10)
	hotbar3.set_name("hotbar_2")
	hotbar3.set_global_position(Vector2(256, 128))
	hotbars.add_child(hotbar3)
