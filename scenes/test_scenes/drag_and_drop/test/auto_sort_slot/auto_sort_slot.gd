extends PanelContainer

@export var droppable: Node

signal draggable_entered(droppable, draggable)
signal draggable_exited(droppable, draggable)
signal draggable_dropped(droppable, draggable)

func _ready() -> void:
	droppable.draggable_entered.connect(_on_draggable_entered)
	droppable.draggable_exited.connect(_on_draggable_exited)
	droppable.draggable_dropped.connect(_on_draggable_dropped)

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
	draggable_entered.emit(self, draggable)

func _on_draggable_exited(draggable) -> void:
	draggable_exited.emit(self, draggable)

func _on_draggable_dropped(draggable) -> void:
	draggable_dropped.emit(self, draggable)
