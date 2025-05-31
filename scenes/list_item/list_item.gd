class_name ListItem
extends Control

@onready var label: Label = $Label
@export var item_name: String

signal start_dragging(list_item: ListItem)
signal drop(list_item: ListItem)

var is_dragging: bool = false
var drag_offset: Vector2 = Vector2.ZERO
	
func _ready() -> void:
	label.text = item_name

func _gui_input(event: InputEvent) -> void:
	if not (event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT):
		return

	# only call once per cycle
	if event.pressed and not is_dragging:
		start_dragging.emit(self)
		is_dragging = true

	if event.pressed:
		drag_offset = get_global_mouse_position() - global_position
		set_z_index(100)
		global_position = get_global_mouse_position() - drag_offset
		return
		
	# handle drop
	drop.emit(self)
	set_z_index(1)
	queue_free()

func _process(delta: float) -> void:
	if is_dragging:
		global_position = get_global_mouse_position() - drag_offset
