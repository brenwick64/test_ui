class_name Draggable
extends Panel

var current_droppable: Droppable
var is_dragging: bool = false
var drag_offset: Vector2

func _gui_input(event: InputEvent) -> void:
	if not (event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT):
		return

	# only call once per cycle
	if event.pressed and not is_dragging:
		is_dragging = true

	if event.pressed:
		drag_offset = get_global_mouse_position() - global_position
		set_z_index(100)
		global_position = get_global_mouse_position() - drag_offset
		return
	
	# is dropped
	if not current_droppable:
		queue_free()
		return
		
	current_droppable.handle_unhover()
	current_droppable.handle_drop(self)

func _process(_delta: float) -> void:
	if is_dragging:
		global_position = get_global_mouse_position() - drag_offset
		var hovered: Control = get_viewport().gui_get_hovered_control()
		var is_valid_hovered: bool = hovered is Droppable and hovered.is_droppable
		
		if is_valid_hovered:
			if current_droppable:
				current_droppable.handle_unhover()
			hovered.handle_hover()
			current_droppable = hovered
			
		elif not is_valid_hovered and current_droppable:
			current_droppable.handle_unhover()
			current_droppable = null
