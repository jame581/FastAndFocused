extends CharacterBody2D

var current_speed : float = 0.0 
@export var speed_array: Array[float] = [100.0, 150.0, 200.0]
var speed_index = 0

func _physics_process(delta: float) -> void:
	velocity.x = current_speed
	move_and_slide()

func race_start() -> void:
	speed_index = 0
	current_speed = speed_array[speed_index]

func race_next_stage() -> void:
	speed_index += 1
	current_speed = speed_array[speed_index]

func race_end() -> void:
	current_speed = 0.0
