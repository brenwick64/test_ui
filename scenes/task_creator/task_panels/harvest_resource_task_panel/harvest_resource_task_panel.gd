extends Panel

@onready var label: Label = $Label
@onready var draggable: Draggable = $Draggable

@export var harvestable: RHarvestable
@export var amount: int

func _ready() -> void:
	label.text = label.text.replace("%action", harvestable.action)
	if amount == 1:
		label.text = label.text.replace("%harvestable", harvestable.name)
	else:
		label.text = label.text.replace("%harvestable", harvestable.plural_name)
	label.text = label.text.replace("%amount", str(amount))

# overrides for draggable
func _process(delta: float) -> void:
	draggable.handle_process(delta)

func _input(input: InputEvent) -> void:
	draggable.handle_input(input)

func _gui_input(input: InputEvent) -> void:
	draggable.handle_gui_input(input)
