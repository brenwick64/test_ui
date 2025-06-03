class_name DragAndDropList
extends VBoxContainer

@onready var list_slot_scene: PackedScene = preload("res://scenes/test_scenes/drag_and_drop/list_slot.tscn")

@export var MAX_LIST_SLOTS: int = 3
@export var LIST_SLOT_HEIGHT: int = 20

func _ready() -> void:
	for i: int in range(MAX_LIST_SLOTS):
		var list_slot: Droppable = list_slot_scene.instantiate()
		list_slot.min_size_y = LIST_SLOT_HEIGHT
		list_slot.hovered.connect(_on_list_slot_hovered)
		list_slot.unhovered.connect(_on_list_slot_unhovered)
		list_slot.drop.connect(_on_list_slot_drop)
		add_child(list_slot)

# helper functions
func _shift_open_slots() -> void:
	for list_slot: Droppable in get_children():
		# move empty slots to last position
		if list_slot.get_child_count() == 0:
			move_child(list_slot, MAX_LIST_SLOTS)

func _get_next_droppable_node() -> Control:
	for node: Droppable in get_children():
		if node.get_child_count() == 0: return node
	return null
	
func _unfocus_all_slots() -> void:
	for node: Droppable in get_children():
		node.unfocus()

# signal handlers
func _on_list_slot_hovered(list_slot: Droppable) -> void:
	var droppable_node: Droppable = _get_next_droppable_node()
	if droppable_node:
		droppable_node.focus()

func _on_list_slot_unhovered(list_slot: Droppable) -> void:
	var droppable_node: Droppable = _get_next_droppable_node()
	if droppable_node:
		droppable_node.unfocus()

func _on_list_slot_drop(list_slot: Droppable, draggable: Draggable) -> void:
	var droppable_node: Droppable = _get_next_droppable_node()
	if droppable_node:
		var draggable_copy: Draggable = draggable.duplicate()
		draggable.queue_free()
		draggable_copy.draggable_dropped.connect(_on_list_slot_item_draggable_dropped)
		droppable_node.add_child(draggable_copy)
		_unfocus_all_slots()

func _on_list_slot_item_draggable_dropped(draggable: Draggable) -> void:
	_shift_open_slots()
