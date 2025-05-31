class_name Draggable
extends Panel

var current_droppable: Droppable
var is_node_hoisted: bool = false
var is_dragging: bool = false
var drag_offset: Vector2

# helpers
func _handle_drop() -> void:
	if current_droppable:
		current_droppable.handle_unhover()
		current_droppable.handle_drop(self)
		return
	queue_free()

func _start_dragging() -> void:
		is_dragging = true
		drag_offset = get_viewport().get_mouse_position() - global_position
		set_z_index(100)
		global_position = get_viewport().get_mouse_position() - drag_offset

func _update_draggable_position() -> void:
	if not is_node_hoisted:
		var main_scene: Node2D = get_tree().get_first_node_in_group("MainScene")
		reparent(main_scene)
		main_scene.move_child(self, 0)
		is_node_hoisted = true
		
	#global_position = get_global_mouse_position() - drag_offset
	global_position = get_viewport().get_mouse_position() - drag_offset

func _update_hover_state() -> void:
	var hovered_control: Control = get_viewport().gui_get_hovered_control()

	if hovered_control is Droppable:
		if current_droppable and current_droppable != hovered_control:
			current_droppable.handle_unhover()
		hovered_control.handle_hover()
		current_droppable = hovered_control
		
	elif current_droppable:
		current_droppable.handle_unhover()
		current_droppable = null

# overrides
func _input(event: InputEvent) -> void:
	if not is_dragging: return
	var is_left_click: bool = event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT
	if is_left_click and event.is_action_released:
		_handle_drop()

func _gui_input(event: InputEvent) -> void:
	var is_left_click: bool = event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT
	if is_left_click and event.is_action_pressed and not is_dragging:
		_start_dragging()

func _process(_delta: float) -> void:
	if not is_dragging: return
	_update_draggable_position()
	_update_hover_state()
