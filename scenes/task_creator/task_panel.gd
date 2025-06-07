extends Panel

@onready var label: Label = $Label

@export var resource: Dictionary
@export var amount: int

func _ready() -> void:
	label.text = label.text.replace("%action", resource.action)
	if amount == 1:
		label.text = label.text.replace("%resource", resource.name)
	else:
		label.text = label.text.replace("%resource", resource.plural_name)
	label.text = label.text.replace("%amount", str(amount))
