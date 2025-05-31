extends Control

func _get_drag_data(at_position: Vector2) -> Variant:
	print(self)
	return self

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return data is Control
	
func _drop_data(at_position: Vector2, data: Variant) -> void:
	pass
