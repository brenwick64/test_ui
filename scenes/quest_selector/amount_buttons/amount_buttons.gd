extends HBoxContainer

signal amount_changed(amount: int)

@onready var label: Label = $Label
@onready var value: int

func set_current_amount(amount: int):
	value = amount
	_update_label()

func _update_label() -> void:
	label.text = str(value)

func _ready() -> void:
	_update_label()

func _on_increment_pressed() -> void:
	value = clampi(value + 1, 1, 9)
	_update_label()
	amount_changed.emit(value)

func _on_decrement_pressed() -> void:
	value = clampi(value - 1, 1, 9)
	_update_label()
	amount_changed.emit(value)
