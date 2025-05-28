extends Node

var last_selected_element: Control

func get_last_selected_element() -> Control:
	return last_selected_element

func set_last_selected_element(element: Control):
	if element:
		last_selected_element = element.duplicate()
	else:
		last_selected_element = null
