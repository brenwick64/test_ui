extends Panel

func show_hover() -> void:
	var original_stylebox: StyleBoxFlat = get_theme_stylebox("panel")
	var stylebox = original_stylebox.duplicate() as StyleBoxFlat
	stylebox.set_border_width_all(2)
	stylebox.border_color = Color("blue")
	add_theme_stylebox_override("panel", stylebox)

func hide_hover() -> void:
	remove_theme_stylebox_override("panel")
