extends Control

@export var action_label: Label
@export var amount_label: Label
@export var resource_label: Label

@onready var resource_buttons: HBoxContainer = $VBoxContainer/Panel/ResourceButtons
@onready var amount_buttons: HBoxContainer = $VBoxContainer/Panel/AmountButtons

@onready var resource_map: Dictionary = {
	"tree": {"name": "tree", "plural_name": "trees", "action": "chop"},
	"rock": {"name": "rock", "plural_name": "rocks", "action": "mine"},
	"fish": {"name": "fish", "plural_name": "fish", "action": "catch"},
}

@onready var current_resource: String = "tree"
@onready var current_amount: int = 1

func _ready() -> void:
	resource_buttons.set_current_resource(current_resource)
	amount_buttons.set_current_amount(current_amount)
	_update_quest_text()

func _update_quest_text() -> void:
	var resource_info: Dictionary = resource_map.get(current_resource)
	action_label.text = resource_info.action
	amount_label.text = str(current_amount)
	if current_amount == 1:
		resource_label.text = resource_info.name
	elif current_amount > 1:
		resource_label.text = resource_info.plural_name

func _on_resource_buttons_resource_changed(resource: String) -> void:
	current_resource = resource
	_update_quest_text()

func _on_amount_buttons_amount_changed(amount: int) -> void:
	current_amount = amount
	_update_quest_text()
