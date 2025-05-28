extends Control

@onready var list_item_scene: PackedScene = preload("res://scenes/list_item/list_item.tscn")
@onready var panel: Panel = $Panel
@onready var list: VBoxContainer = $Panel/VBoxContainer2/List

var dragged_in: bool = false
var hover_stylebox: StyleBoxFlat = StyleBoxFlat.new()

func _ready() -> void:
	hover_stylebox.bg_color = Color("red")

func _handle_drag_in() -> void:
	dragged_in = true
	print("drag_in")

func _handle_drag_out() -> void:
	dragged_in = false
	print("drag_out")
	
func _handle_drop() -> void:
	print("drop")
	dragged_in = false
	var dropped_element: Control = DragAndDropManager.get_last_selected_element()
	DragAndDropManager.set_last_selected_element(null)
	if dropped_element:
		var list_item: Control = list_item_scene.instantiate()
		var item_label: Label = list_item.get_node("Label")
		item_label.text = str(dropped_element)
		list.add_child(dropped_element)
	
func _process(_delta: float) -> void:
	var mouse_pos = get_local_mouse_position()
	
	var is_hovered: bool = Rect2(Vector2.ZERO, size).has_point(mouse_pos)
	var is_dragging: bool = Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	
	#if not DragAndDropManager.get_last_selected_element(): return
		
	if (is_hovered and is_dragging) and not dragged_in:
		_handle_drag_in()
	elif (not is_hovered and is_dragging) and dragged_in:
		_handle_drag_out()
	elif (is_hovered and not is_dragging) and dragged_in:
		_handle_drop()
