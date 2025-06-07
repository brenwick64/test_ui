extends HBoxContainer

signal harvestable_changed(resource: RHarvestable)

# harvestable resources
@onready var  tree = preload("res://resources/harvestables/tree.tres")
@onready var  rock = preload("res://resources/harvestables/rock.tres")
@onready var  fish = preload("res://resources/harvestables/fish.tres")
@onready var HARVESTABLES = [tree, rock, fish]

# ui elements
@onready var left_btn: Button = $LeftBtn
@onready var image_container: Container = $PanelContainer
@onready var right_btn: Button = $RightBtn

var current_harvestable: RHarvestable 

# helper functions
func _get_harvestable_index(harvestable: RHarvestable):
	for i: int in HARVESTABLES.size():
		if HARVESTABLES[i] == current_harvestable:
			return i
	push_error("HarvestableButtons error: current harvestable not found in HARVESTABLES") 
	return -1

func _update_ui():
	if image_container.get_child_count() > 0:
		var image: TextureRect = image_container.get_children()[0]
		image.queue_free()
	var new_image: TextureRect = current_harvestable.image_scene.instantiate()
	image_container.add_child(new_image)

# methods
func set_harvestable(harvestable: RHarvestable):
	current_harvestable = harvestable
	_update_ui()
	
# signals
func _on_left_pressed():
	var current_harvestable_idx: int = _get_harvestable_index(current_harvestable)
	if current_harvestable_idx == 0:
		set_harvestable(HARVESTABLES[HARVESTABLES.size() - 1])
	else:
		set_harvestable(HARVESTABLES[current_harvestable_idx - 1])
	harvestable_changed.emit(current_harvestable)

func _on_right_pressed():
	var current_harvestable_idx: int = _get_harvestable_index(current_harvestable)
	if current_harvestable_idx == HARVESTABLES.size() - 1:
		set_harvestable(HARVESTABLES[0])
	else:
		set_harvestable(HARVESTABLES[current_harvestable_idx + 1])
	harvestable_changed.emit(current_harvestable)
