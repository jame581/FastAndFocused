extends Area2D
class_name Obstacle

@export_category("Obstacle Settings")
@export var obstacle_enum : Constants.ObstacleEnum = Constants.ObstacleEnum.NONE

@export_category("Obstacle Settings")
@export var obstacle_duration : float

func _ready() -> void:	
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if(body is Animal):
		body.affect_with_obstacle(obstacle_enum, obstacle_duration)
		queue_free();
