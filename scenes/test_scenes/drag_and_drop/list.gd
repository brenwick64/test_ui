class_name List
extends Control

signal start_dragging(list_item: ListItem)
signal drop(list_item: ListItem)

@onready var list_item_scene: PackedScene = preload("res://scenes/list_item/list_item.tscn")
@onready var item_slot: Panel = $ItemSlot
@onready var item_slot_2: Panel = $ItemSlot2
@onready var item_slot_3: Panel = $ItemSlot3

# TODO: Get rid of 
@onready var list_item_slots: Array[Panel] = [
	item_slot,
	item_slot_2,
	item_slot_3
]
@export var drag_and_drop_context: DragAndDropContext
@export var MAX_LIST_ITEMS: int = 3
@export var list_items: Array[String] = []

var dragged_item: Control
var draggable_entered: bool = false

# helper functions
func _clear_hover() -> void:
	for item_slot: Panel in get_children():
		item_slot.hide_hover()

func _render_list_items() -> void:
	for i: int in list_items.size():
		var list_item: ListItem = list_item_scene.instantiate()
		list_item.item_name = list_items[i]
		list_item.start_dragging.connect(_on_start_dragging)
		list_item.drop.connect(_on_drop)
		list_item_slots[i].add_child(list_item)
		
func _get_next_open_item_slot() -> Panel:
	for item_slot: Node in get_children():
		if item_slot.get_child_count() == 0:
			return item_slot
	return null
		
func _add_list_item(list_item: ListItem) -> void:
	var empty_item_slot: Panel = _get_next_open_item_slot()
	if empty_item_slot:
		var last_dragged: ListItem = drag_and_drop_context.last_dragged
		last_dragged.start_dragging.connect(_on_start_dragging)
		last_dragged.drop.connect(_on_drop)
		empty_item_slot.add_child(last_dragged)
		print(str(last_dragged) + "added")

func _handle_drop() -> void:
	draggable_entered = false
	# check if there is an item being dragged
	var last_dragged: ListItem = drag_and_drop_context.last_dragged
	if not last_dragged: return
	#TODO: fix this
	#if list_items.size() >= MAX_LIST_ITEMS: return
	
	_add_list_item(dragged_item)
	_clear_hover()
	drag_and_drop_context.reset()
	
func _handle_draggable_entered() -> void:
	print("draggable entered")
	draggable_entered = true
	var next_open_slot: Panel = _get_next_open_item_slot()
	if next_open_slot:
		next_open_slot.show_hover()
	
func _handle_draggable_exited() -> void:
	print("draggable exited")
	draggable_entered = false
	for item_slot: Panel in get_children():
		item_slot.hide_hover()

func _ready() -> void:
	_render_list_items()

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

func _on_start_dragging(list_item: ListItem) -> void:
	start_dragging.emit(list_item)
	
func _on_drop(list_item: ListItem) -> void:
	_clear_hover()
	drop.emit(list_item)
