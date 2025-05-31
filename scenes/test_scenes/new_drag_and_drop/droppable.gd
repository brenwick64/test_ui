class_name Droppable
extends VBoxContainer

var is_droppable: bool

func _check_is_droppable() -> bool:
	for node: Node in get_children():
		if node.get_child_count() == 0: return true
	return false
	
func _get_droppable_node() -> Control:
	for node: Node in get_children():
		if node.get_child_count() == 0: return node
	return null

func _ready() -> void:
	is_droppable = _check_is_droppable()

func handle_hover() -> void:
	print("hover")
	if not _check_is_droppable(): return
	var droppable_node: Control = _get_droppable_node()
	var original_stylebox: StyleBoxFlat = droppable_node.get_theme_stylebox("panel")
	var stylebox = original_stylebox.duplicate() as StyleBoxFlat
	stylebox.set_border_width_all(2)
	stylebox.border_color = Color("blue")
	droppable_node.add_theme_stylebox_override("panel", stylebox)

func handle_unhover() -> void:
	if not _check_is_droppable(): return
	var droppable_node: Control = _get_droppable_node()
	droppable_node.remove_theme_stylebox_override("panel")

func handle_drop(control: Control) -> void:
	if _check_is_droppable():
		var control_cpy: Control = control.duplicate()
		_get_droppable_node().add_child(control_cpy)
	control.queue_free()
