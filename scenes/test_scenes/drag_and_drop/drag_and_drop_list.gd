class_name DragAndDropList
extends VBoxContainer

func _ready() -> void:
	for list_slot: Droppable in get_children():
		list_slot.hovered.connect(_on_list_slot_hovered)
		list_slot.unhovered.connect(_on_list_slot_unhovered)
		list_slot.drop.connect(_on_list_slot_drop)

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
		droppable_node.add_child(draggable_copy)
		draggable.queue_free()
		_unfocus_all_slots()
