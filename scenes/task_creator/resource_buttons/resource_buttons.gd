extends HBoxContainer

signal resource_changed(resource: String)

@onready var tree: TextureRect = $Tree
@onready var rock: TextureRect = $Rock
@onready var fish: TextureRect = $Fish

@onready var resource_mappings: Array[Dictionary] = [
	{ "resource" : "tree", "action": "chop", "icon": tree },
	{ "resource" : "rock", "action": "mine", "icon": rock },
	{ "resource" : "fish", "action": "catch", "icon": fish }
]
var current_resource: String 

func set_current_resource(resource: String):
	current_resource = resource
	_update_resource_image()

func _update_resource_image() -> void:
	for mapping: Dictionary in resource_mappings:
		if mapping.resource == current_resource:
			mapping.icon.visible = true
		else:
			mapping.icon.visible = false

func _ready() -> void:
	print("button resource " + current_resource)
	_update_resource_image()

func _on_left_pressed() -> void:
	var resource_index: int = -1
	for i: int in resource_mappings.size():
		if resource_mappings[i].resource == current_resource:
			resource_index = i
	# guard clause for not found
	if resource_index == -1: return
	if resource_index == 0:
		current_resource = resource_mappings[resource_mappings.size() - 1].resource
	else:
		current_resource = resource_mappings[resource_index - 1].resource
	resource_changed.emit(current_resource)
	_update_resource_image()

func _on_right_pressed() -> void:
	var resource_index: int = -1
	for i: int in resource_mappings.size():
		if resource_mappings[i].resource == current_resource:
			resource_index = i
	# guard clause for not found
	if resource_index == -1: return
	if resource_index == resource_mappings.size() -1:
		current_resource = resource_mappings[0].resource
	else:
		current_resource = resource_mappings[resource_index + 1].resource
	resource_changed.emit(current_resource)
	_update_resource_image()
	
