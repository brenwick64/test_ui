class_name Droppable
extends Control

signal hovered(droppable: Droppable)
signal unhovered(droppable: Droppable)
signal drop(droppable: Droppable, draggable: Draggable)

# signal handlers
func handle_hover() -> void:
	hovered.emit(self)

func handle_unhover() -> void:
	unhovered.emit(self)

func handle_drop(draggable: Draggable) -> void:
	drop.emit(self, draggable)

# methods
func focus() -> void:
	var original_stylebox: StyleBoxFlat = get_theme_stylebox("panel")
	var stylebox = original_stylebox.duplicate() as StyleBoxFlat
	stylebox.set_border_width_all(2)
	stylebox.border_color = Color("blue")
	add_theme_stylebox_override("panel", stylebox)

func unfocus() -> void:
	remove_theme_stylebox_override("panel")
