extends Panel

@onready var draggable: Node = $Draggable
signal dropped

func _ready() -> void:
	#draggable.parent_ui = self
	draggable.dropped.connect(_on_draggable_dropped)

func _process(delta: float) -> void:
	draggable.handle_process(delta)

func _input(input: InputEvent) -> void:
	draggable.handle_input(input)

func _gui_input(input: InputEvent) -> void:
	draggable.handle_gui_input(input)

func _on_draggable_dropped(parent_ui: Control):
	dropped.emit()
	queue_free()
