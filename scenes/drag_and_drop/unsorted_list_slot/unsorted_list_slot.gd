extends PanelContainer

@export var droppable: Droppable

func _ready() -> void:
	droppable.draggable_entered.connect(_on_draggable_entered)
	droppable.draggable_exited.connect(_on_draggable_exited)
	droppable.draggable_dropped.connect(_on_draggable_dropped)

# helper functions
func _is_empty() -> bool: 
	return get_child_count() == 1

# methods
func focus() -> void:
	var original_stylebox: StyleBoxFlat = get_theme_stylebox("panel")
	var stylebox = original_stylebox.duplicate() as StyleBoxFlat
	stylebox.set_border_width_all(2)
	stylebox.border_color = Color("blue")
	add_theme_stylebox_override("panel", stylebox)

func unfocus() -> void:
	remove_theme_stylebox_override("panel")

# signal handlers
func _on_draggable_entered(draggable) -> void:
	focus()

func _on_draggable_exited(draggable) -> void:
	unfocus()

func _on_draggable_dropped(draggable) -> void:
	if not _is_empty(): return
	var draggable_cpy: Control = draggable.duplicate()
	unfocus()
	add_child(draggable_cpy)
