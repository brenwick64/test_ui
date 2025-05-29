class_name ListItem
extends Control

@onready var label: Label = $Label

@export var item_name: String

signal is_dragged

var is_dragging: bool = false
var drag_offset: Vector2 = Vector2.ZERO
	
func _ready() -> void:
	label.text = item_name

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			# Start dragging
			is_dragging = true
			drag_offset = get_global_mouse_position() - global_position
			set_z_index(100)  # Bring to front
			DragAndDropManager.set_last_selected_element(self)
		else:
			set_z_index(1)
			queue_free()

func _process(delta: float) -> void:
	if is_dragging:
		global_position = get_global_mouse_position() - drag_offset
