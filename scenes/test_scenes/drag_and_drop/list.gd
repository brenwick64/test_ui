extends Control

@onready var list_item_scene: PackedScene = preload("res://scenes/list_item/list_item.tscn")

var item_data: Array[String] = [
	"Item 1",
	"Item 2",
	"Item 3"
]

#func _ready() -> void:
	#for item: String in item_data:
		#var list_item: Control = list_item_scene.instantiate()
		#var list_label: Label = list_item.get_node("Label")
		#list_label.text = item
		#v_box_container.add_child(list_item)
