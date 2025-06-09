extends Panel

#exports
@export var default_harvestable: RHarvestable
@export var default_amount: int

@onready var task_panel_scene: PackedScene = preload("res://scenes/task_creator/task_panels/harvest_resource_task_panel/harvest_resource_task_panel.tscn")
@onready var harvestable_buttons: HBoxContainer = $HarvestableButtons
@onready var amount_buttons: HBoxContainer = $AmountButtons

# variables
var current_harvestable: RHarvestable
var current_amount: int

# methods
func create_task_panel() -> Panel:
	var task_panel_ins: Panel = task_panel_scene.instantiate()
	task_panel_ins.harvestable = current_harvestable
	task_panel_ins.amount = current_amount
	return task_panel_ins

func _ready() -> void:
	current_harvestable = default_harvestable
	current_amount = default_amount
	harvestable_buttons.set_harvestable(current_harvestable)
	amount_buttons.set_value(current_amount)

func _on_harvestable_buttons_harvestable_changed(harvestable: RHarvestable) -> void:
	current_harvestable = harvestable

func _on_amount_buttons_amount_changed(amount: int) -> void:
	current_amount = amount
