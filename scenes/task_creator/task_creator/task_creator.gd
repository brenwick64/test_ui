extends VBoxContainer

@onready var task_panel_container: PanelContainer = $TaskPanelContainer
@onready var task_config: VBoxContainer = $TaskConfig

# helper functions
func _add_new_task_panel(task_panel: Panel):
	for child: Node in task_panel_container.get_children():
		child.queue_free()
	task_panel_container.add_child(task_panel)

func _on_create_task_btn_pressed() -> void:
	if task_config.get_child_count() == 0:
		return
	var config_panel: Panel = task_config.get_children()[0]
	var task_panel: Panel = config_panel.create_task_panel()
	_add_new_task_panel(task_panel)
