class_name Droppable
extends Node

signal draggable_entered(draggable)
signal draggable_exited(draggable)
signal draggable_dropped(draggable)

# public methods for draggable
func handle_draggable_entered(draggable) -> void:
	draggable_entered.emit(draggable)

func handle_draggable_exited(draggable) -> void:
	draggable_exited.emit(draggable)

func handle_draggable_dropped(draggable) -> void:
	draggable_dropped.emit(draggable)
