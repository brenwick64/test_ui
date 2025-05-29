extends Control

@onready var list_item_scene: PackedScene = preload("res://scenes/list_item/list_item.tscn")
@onready var panel: Panel = $Panel
@onready var list: VBoxContainer = $Panel/VBoxContainer2/List

var draggable_entered: bool = false

func _handle_draggable_entered() -> void:
	var stylebox: StyleBoxFlat = panel.get_theme_stylebox("panel")
	stylebox.border_color = Color("blue")
	stylebox.set_border_width_all(2)
	draggable_entered = true

func _handle_draggable_exited() -> void:
	draggable_entered = false
	
func _handle_drop() -> void:
	draggable_entered = false
	var dropped_element: Control = DragAndDropManager.get_last_selected_element()
	DragAndDropManager.set_last_selected_element(null)
	if dropped_element:
		var list_item: Control = list_item_scene.instantiate()
		list_item.item_name = str(dropped_element)
		list.add_child(dropped_element)
	
func _process(_delta: float) -> void:
	var mouse_pos = get_local_mouse_position()
	
	var is_hovered: bool = Rect2(Vector2.ZERO, size).has_point(mouse_pos)
	var is_dragging: bool = Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)
			
	if not draggable_entered and (is_hovered and is_dragging):
		_handle_draggable_entered()
	elif draggable_entered and (not is_hovered and is_dragging):
		_handle_draggable_exited()
	elif draggable_entered and (is_hovered and not is_dragging):
		_handle_drop()
