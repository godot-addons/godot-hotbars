extends TextureButton

const STATUS_NONE = 0
const STATUS_CLICKED = 1
const STATUS_DRAGGING = 2
const STATUS_DRAGGED = 3
const STATUS_RELEASED = 4

export(bool) var allow_drag = true
export(bool) var use_snap = true
export(int) var snap_size = 5
export(bool) var locked = false setget set_locked, get_locked

onready var parent = get_parent().get_parent()

var status = STATUS_NONE
var offset = Vector2()
var mpos = Vector2()

func _ready():
	set_process(true)
	set_process_input(true)

func _process(delta):
	if allow_drag && status == STATUS_DRAGGING:
		if !use_snap:
			parent.set_global_position(mpos + offset)
		else:
			parent.set_global_position(snap(mpos + offset))

func _input(ev):
#	if !allow_drag || (ev.type != InputEvent.MOUSE_BUTTON && ev.type != InputEvent.MOUSE_MOTION):
#		return

	if !allow_drag || (!(ev is InputEventMouseButton) && !(ev is InputEventMouseMotion)):
		return

	if ev is InputEventMouseButton && !ev.is_pressed():
		status = STATUS_NONE

	# Start dragging
	if ev is InputEventMouseButton && ev.button_index == BUTTON_LEFT && ev.is_pressed() && status != STATUS_DRAGGING:
#		var ev_pos = ev.global_pos
		var ev_pos = ev.position
		var gpos = get_global_position()
		var s = get_size()

#		if Rect2(gpos.x, gpos.y, s.x, s.y).has_point(ev_pos) && is_stopping_mouse():
		if Rect2(gpos.x, gpos.y, s.x, s.y).has_point(ev_pos):
			status = STATUS_CLICKED
			offset = gpos - ev_pos

			# Move the currently selected hotbar to the last index of parent
			# so that the hotbar is always on top of the others
			var hotbars = parent.get_parent()
			hotbars.move_child(parent, hotbars.get_child_count() - 1)

	if status == STATUS_CLICKED && ev is InputEventMouseMotion:
		status = STATUS_DRAGGING

	if status == STATUS_DRAGGING && ev is InputEventMouseButton && ev.button_index == BUTTON_LEFT && !ev.is_pressed():
		status = STATUS_RELEASED

	if ev is InputEventMouseMotion:
		mpos = ev.position

func snap(pos):
	return Vector2(ceil(pos.x / snap_size) * snap_size, ceil(pos.y / snap_size) * snap_size)

func set_locked(locked_):
	locked = locked_
	lock(locked)

func get_locked(): return locked

func lock(lock):
	return
	var p = get_parent()
	if lock == true:
		set_hidden(true)
		p.set_columns(p.get_columns().size - 1)
	else:
		set_hidden(false)
		p.set_columns(p.get_columns().size + 1)
