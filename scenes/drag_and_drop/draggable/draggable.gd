class_name Draggable
extends Node

@export var parent_ui: Control

signal dropped

var is_dragging: bool = false
var is_draggable_hoisted: bool = false
var drag_offset: Vector2
var current_hovered_droppable: Control

# helper functions
func _start_dragging() -> void:
		is_dragging = true
		drag_offset = get_viewport().get_mouse_position() - parent_ui.global_position
		parent_ui.set_z_index(100)
		parent_ui.global_position = get_viewport().get_mouse_position() - drag_offset

func _update_draggable_position() -> void:
	#TODO: maybe there is a better way of handling z-index?
	if not is_draggable_hoisted:
		var main_scene: Node2D = get_tree().get_first_node_in_group("MainScene")
		parent_ui.reparent(main_scene)
		main_scene.move_child(parent_ui, 0)
		is_draggable_hoisted = true
		
	parent_ui.global_position = get_viewport().get_mouse_position() - drag_offset

func _check_droppable():
	var is_droppable: bool = false
	var hovered_control: Control = get_viewport().gui_get_hovered_control()
	if hovered_control:
		is_droppable = not not hovered_control.get_node_or_null("Droppable")
		
	# no droppable is hovered
	if not hovered_control or not is_droppable:
		if current_hovered_droppable:
			current_hovered_droppable.droppable.handle_draggable_exited(parent_ui)
			current_hovered_droppable = null
			
	# brand new droppable is hovered
	elif not current_hovered_droppable and is_droppable:
		hovered_control.droppable.handle_draggable_entered(parent_ui)
		current_hovered_droppable = hovered_control
	
	# new droppable is replacing existing droppable
	elif current_hovered_droppable and is_droppable and current_hovered_droppable != hovered_control:
		current_hovered_droppable.droppable.handle_draggable_exited(parent_ui)	
		hovered_control.droppable.handle_draggable_entered(parent_ui)
		current_hovered_droppable = hovered_control

# overrides
func handle_input(event: InputEvent) -> void:
	if not is_dragging: return
	var is_left_click: bool = event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT
	if is_left_click and event.is_action_released:
		if current_hovered_droppable:
			current_hovered_droppable.droppable.handle_draggable_dropped(parent_ui)
		dropped.emit()
		parent_ui.queue_free()

func handle_gui_input(event: InputEvent) -> void:
	var is_left_click: bool = event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT
	if is_left_click and event.is_action_pressed and not is_dragging:
		_start_dragging()

func handle_process(_delta: float) -> void:
	if not is_dragging: return
	_update_draggable_position()
	_check_droppable()
