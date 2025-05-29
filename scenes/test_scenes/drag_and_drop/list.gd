extends Control

@onready var list_item_scene: PackedScene = preload("res://scenes/list_item/list_item.tscn")

@onready var list_item_slot: Panel = $ListItemSlot
@onready var list_item_slot_2: Panel = $ListItemSlot2
@onready var list_item_slot_3: Panel = $ListItemSlot3

var dragged_item: Control

@onready var list_item_slots: Array[Panel] = [
	list_item_slot,
	list_item_slot_2,
	list_item_slot_3
]

var item_data: Array[String] = [
	"Item1",
	"Item2"
]

# helper functions

func _ready() -> void:
	for i: int in item_data.size():
		var list_item: ListItem = list_item_scene.instantiate()
		list_item.item_name = item_data[i]
		list_item_slots[i].add_child(list_item)

func _process(_delta: float) -> void:
	var mouse_pos = get_local_mouse_position()
	
	var is_hovered: bool = Rect2(Vector2.ZERO, size).has_point(mouse_pos)
	var is_dragging: bool = Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)
			
	#if not draggable_entered and (is_hovered and is_dragging):
		#_handle_draggable_entered()
	#elif draggable_entered and (not is_hovered and is_dragging):
		#_handle_draggable_exited()
	#elif draggable_entered and (is_hovered and not is_dragging):
		#_handle_drop()
