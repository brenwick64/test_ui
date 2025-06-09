extends VBoxContainer

signal list_updated(list_elements: Array[Control])

var MAX_LIST_SLOTS: int

# methods
func clear_list() -> void:
	for list_slot: PanelContainer in get_children():
		var element: Control = list_slot.get_element()
		if element: element.queue_free()
	_unfocus_all_slots()

func _ready() -> void:
	MAX_LIST_SLOTS = get_child_count()
	for child_node: Node in get_children():
		child_node.draggable_entered.connect(_on_entered)
		child_node.draggable_exited.connect(_on_exited)
		child_node.draggable_dropped.connect(_on_dropped)

# helper functions
func _signal_list_updated() -> void:
	var elements: Array[Control] = []
	for list_slot: Node in get_children():
		var list_element: Control = list_slot.get_element()
		if list_element: 
			elements.append(list_element)
	list_updated.emit(elements)

func _get_next_droppable_node() -> Control:
	for node: Control in get_children():
		if node.get_child_count() == 1: return node
	return null
	
func _shift_open_slots() -> void:
	for list_slot: Control in get_children():
		# move empty slots to last position
		if list_slot.get_child_count() == 1:
			move_child(list_slot, MAX_LIST_SLOTS)

func _unfocus_all_slots() -> void:
	for node: Control in get_children():
		node.unfocus()

func _on_entered(droppable, draggable) -> void:
	_get_next_droppable_node().focus()
	
func _on_exited(droppable, draggable) -> void:
	_unfocus_all_slots()
	
func _on_dropped(droppable, draggable) -> void:
	var open_slot: PanelContainer = _get_next_droppable_node()
	if not open_slot: return
	var draggable_cpy: Control = draggable.duplicate()
	var draggable_node: Draggable = draggable_cpy.get_node_or_null("Draggable")
	draggable_node.dropped.connect(_on_draggable_dropped)
	open_slot.add_child(draggable_cpy)
	call_deferred("_signal_list_updated")

func _on_draggable_dropped():
	_shift_open_slots()
