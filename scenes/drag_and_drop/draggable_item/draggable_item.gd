extends Panel

@export var item_name: String

@onready var draggable: Draggable = $Draggable
@onready var label: Label = $Label

signal dropped

func _ready() -> void:
	label.text = item_name
	draggable.dropped.connect(_on_draggable_dropped)

func _process(delta: float) -> void:
	draggable.handle_process(delta)

func _input(input: InputEvent) -> void:
	draggable.handle_input(input)

func _gui_input(input: InputEvent) -> void:
	draggable.handle_gui_input(input)

func _on_draggable_dropped(parent_ui: Control) -> void:
	dropped.emit()
	queue_free()
