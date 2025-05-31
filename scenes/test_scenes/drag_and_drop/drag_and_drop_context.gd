class_name DragAndDropContext
extends Control

var last_dragged: Node

@onready var list: List = $List
@onready var list_2: List = $List2
@onready var lists: Array[List] = [list, list_2]

func _ready() -> void:
	for list: List in lists:
		list.start_dragging.connect(_on_start_dragging)
		list.drop.connect(_on_drop)

func _on_start_dragging(list_item: ListItem) -> void:
	last_dragged = list_item.duplicate()
	print("start dragging: " + str(list_item))
	
func _on_drop(list_item: ListItem) -> void:
	print("dropped: " + str(list_item))

func reset() -> void:
	print("reset context")
	last_dragged = null
