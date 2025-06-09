extends VBoxContainer

@onready var auto_sort_list: VBoxContainer = $AutoSortList
var task_list: Array[Control]

func _on_auto_sort_list_list_updated(list_elements: Array[Control]) -> void:
	task_list = list_elements

func _on_create_quest_btn_pressed() -> void:
	print(task_list)
	auto_sort_list.clear_list()
	
