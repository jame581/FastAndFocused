extends Node2D

@export_category("Race Settings")
@export var animals: Array[PackedScene]
@export var obstacles: Array[PackedScene]
@export var obstacles_per_stage: int = 4
@export var	obstacles_spawn_offset: Vector2 = Vector2(150, 0)


@onready var start_points_parent: Node2D = $StartPoints
@onready var animals_node: Node2D = $Animals
@onready var obstacles_node: Node2D = $Obstacles
@onready var camera: Camera2D = $Camera2D
@onready var betting_ui: MarginContainer = $UI/BettingUI
@onready var results_ui: MarginContainer = $UI/ResultUI
@onready var race_control_ui: MarginContainer = $UI/RaceControlUI

# Local variables
var start_points: Array[Node2D]
var target_animal: Node2D
var animal_array: Array[Animal]
var animal_finish_order_array : Array[Animal] # contains the order in which the animals finished the race

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
	
	_ui_init()

	SignalBus.race_init.emit()

	# Connect the switch camera
	SignalBus.race_camera_switch.connect(_on_camera_switch)	
	
	SignalBus.animal_finished.connect(_handle_animal_finished)
	SignalBus.race_init.connect(_handle_race_init)
	SignalBus.spawn_race_obstacles.connect(spawn_obstacles)
	SignalBus.race_started.connect(handle_race_started)
	SignalBus.bet_placed.connect(handle_bet_placed)


func _process(_delta: float) -> void:
	# Update camera position to follow the target animal and keep it in view
	if target_animal:
		camera.position.x = target_animal.position.x - (camera.get_viewport_rect().size.x / 2)

func _ui_init() -> void:
	# Initialize the UI elements
	betting_ui.visible = false
	results_ui.visible = false

	betting_ui.set_animals_lineup(animal_array)

func spawn_animals_to_spawn_points() -> void:
	# Spawn animals at the start points
	if start_points.size() == 0:
		push_error("No start points available to spawn animals")
	animal_array = []
	animal_finish_order_array = []
	
	# Create a copy of the animals array to ensure we have unique selections
	var available_animals = animals.duplicate()
	# Ensure we have enough animals or repeat if necessary
	if available_animals.size() == 0:
			push_error("No animal scenes available")
			return
	
	# Shuffle the array to get random selection
	available_animals.shuffle()

	for i in range(start_points.size()):
		# Get animal scene, cycling through the shuffled list if needed
		var animal_scene = available_animals[i % available_animals.size()]
		# # Remove the selected animal to ensure uniqueness
		# if i < available_animals.size():
		# 	available_animals.remove(i % available_animals.size())
	
		var animal_instance = animal_scene.instantiate()
		animal_instance.position = start_points[i].position
		animals_node.add_child(animal_instance)
		animal_array.append(animal_instance)
	
	var animals_ids: Array[Constants.AnimalId] = []
	for animal in animal_array:
		animals_ids.append(animal.id)

	race_control_ui.setup_switch_camera_icons(animals_ids)


func _on_camera_switch(animal_index: int) -> void:
	# Switch camera to the specified animal
	if animal_index < 0 or animal_index >= animals_node.get_child_count():
		push_error("Invalid animal index for camera switch: ", animal_index)
		return
	
	target_animal = animals_node.get_child(animal_index)
	print("Camera switched to animal at index: ", animal_index)

func _handle_animal_finished(animal: Animal):
	if !animal_finish_order_array.has(animal) :
		animal_finish_order_array.append(animal)
	
	if animal_array.size() <= animal_finish_order_array.size():
		SignalBus.race_finished.emit(animal_finish_order_array)

func _handle_race_init() -> void:
	print("Race initialized")

func spawn_obstacles(race_stage: Constants.RaceStage) -> void:
	
	print("Spawning obstacles called for stage ", race_stage)
	# Spawn a random obstacle at a random position
	if obstacles.size() == 0:
		push_error("No obstacles available to spawn")
		return
	
	var offset_stage_x : float = 0.0

	if race_stage == Constants.RaceStage.START:
		offset_stage_x = 315.0
	elif race_stage == Constants.RaceStage.MIDDLE:
		offset_stage_x = 630.0 + 315.0
	elif race_stage == Constants.RaceStage.FINISH:
		offset_stage_x = 945.0 + 315.0 + 315.0
	else:
		push_error("Invalid race stage")

	# Spawn obstacles at the Y axis of start points
	for i in range(obstacles_per_stage):
		var start_point = start_points[i % start_points.size()]
		var obstacle_scene = obstacles[randi() % obstacles.size()]
		var obstacle_instance = obstacle_scene.instantiate()

		obstacle_instance.position.y = start_point.position.y
		obstacle_instance.position.x = start_point.position.x + offset_stage_x
		obstacles_node.call_deferred("add_child", obstacle_instance)


func handle_race_started() -> void:
	spawn_obstacles(Constants.RaceStage.START)


func handle_bet_placed(animal_id: Constants.AnimalId, bet_amount: int) -> void:
	pass
