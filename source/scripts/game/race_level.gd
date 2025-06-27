extends Node2D

@export_category("Race Settings")
@export var animals: Array[PackedScene]


@onready var start_points_parent: Node2D = $StartPoints
@onready var animals_node: Node2D = $Animals
@onready var camera: Camera2D = $Camera2D

# Local variables
var start_points: Array[Node2D]
var target_animal: Node2D

func _ready() -> void:
	# Initialize start points
	start_points = []
    
	# Find all start points in the scene
	for child in start_points_parent.get_children():
		if child is Node2D:
			start_points.append(child)

	# Ensure there are start points available
	if start_points.size() == 0:
		push_error("No start points found")
	else:
		spawn_animals_to_spawn_points()

	if animals_node.get_child_count() > 0:
		target_animal = animals_node.get_child(0)

	SignalBus.race_init.emit()

	# Connect the switch camera
	SignalBus.race_camera_switch.connect(_on_camera_switch)

func _process(_delta: float) -> void:
	# Update camera position to follow the target animal and keep it in view
	if target_animal:
		camera.position.x = target_animal.position.x - (camera.get_viewport_rect().size.x / 2)


func spawn_animals_to_spawn_points() -> void:
	# Spawn animals at the start points
	if start_points.size() == 0:
		push_error("No start points available to spawn animals")
	
	for i in range(start_points.size()):
		var animal_scene = animals[i % animals.size()]
		var animal_instance = animal_scene.instantiate()
		animal_instance.position = start_points[i].position
		animals_node.add_child(animal_instance)
	
func _on_camera_switch(animal_index: int) -> void:
	# Switch camera to the specified animal
	if animal_index < 0 or animal_index >= animals_node.get_child_count():
		push_error("Invalid animal index for camera switch: ", animal_index)
		return
	
	target_animal = animals_node.get_child(animal_index)
	print("Camera switched to animal at index: ", animal_index)