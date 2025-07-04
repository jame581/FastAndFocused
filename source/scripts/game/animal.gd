extends CharacterBody2D

class_name Animal

@export_category("Animal Settings")
@export var id: Constants.AnimalId = Constants.AnimalId.BEAVER
@export var speed_array: Array[float] = [100.0, 150.0, 200.0]
@export var obstacle_effect_dict = {
	Constants.ObstacleEnum.SAND_CASTLE: -50.0,
	Constants.ObstacleEnum.FREE_HUGS: 30.0,
	Constants.ObstacleEnum.HONEY: -20.0,
	Constants.ObstacleEnum.SWEATER: 10.0,
	Constants.ObstacleEnum.BATTERY: 50.0,
	Constants.ObstacleEnum.BRICS: -30.0
}

@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Local variables
var current_speed : float = 0.0 
var speed_index = 0
var active_obstacle : Constants.ObstacleEnum = Constants.ObstacleEnum.NONE
var obstacle_timeout : float = 0.0
var race_ended : bool = false


func _ready() -> void:
	SignalBus.race_started.connect(handle_race_started)
	animation_player.play("idle")


func _physics_process(delta: float) -> void:
	if race_ended:
		return

	if (obstacle_timeout < Time.get_ticks_msec() and obstacle_effect_dict.has(active_obstacle)):
		velocity.x = current_speed + obstacle_effect_dict[active_obstacle]
	else:
		velocity.x = current_speed
	
	move_and_collide(velocity * delta)


func race_start() -> void:
	print(name + "Race started")
	speed_index = 0
	current_speed = speed_array[speed_index]
	animation_player.play("movement")
	race_ended = false


func race_next_stage() -> void:
	print(name + "Race advanced to next stage")
	speed_index += 1
	current_speed = speed_array[speed_index]


func race_end() -> void:
	print(name + "Race ended")
	current_speed = 0.0
	SignalBus.animal_finished.emit(self)
	animation_player.play("idle")
	race_ended = true


func handle_race_started() -> void:
	race_start()


func affect_with_obstacle(obstacle: Constants.ObstacleEnum, duration: float) -> void:
	active_obstacle = obstacle
	obstacle_timeout = Time.get_ticks_msec() + duration * 1000.0
	print(name + " affected by obstacle: ", obstacle, " for ", duration, " seconds")
