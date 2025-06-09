extends Panel

@onready var label: Label = $Label
@onready var draggable: Draggable = $Draggable
@onready var panel_container: PanelContainer = $PanelContainer

@export var harvestable: RHarvestable
@export var amount: int

func _update_text() -> void:
	var text: String = label.text
	text = text.replace("%action", harvestable.action)
	text = text.replace("%amount", str(amount))
	if amount == 1:
		text = text.replace("%harvestable", harvestable.name)
	else:
		text = text.replace("%harvestable", harvestable.plural_name)
	label.text = text

func _add_harvestable_image() -> void:
	for child: Node in panel_container.get_children():
		child.queue_free()
	var img: TextureRect = harvestable.image_scene.instantiate()
	panel_container.add_child(img)

func _ready() -> void:
	_update_text()
	_add_harvestable_image()

# overrides for draggable
func _process(delta: float) -> void:
	draggable.handle_process(delta)

func _input(input: InputEvent) -> void:
	draggable.handle_input(input)

func _gui_input(input: InputEvent) -> void:
	draggable.handle_gui_input(input)
