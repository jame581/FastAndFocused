extends Area2D

@export var race_stage : Constants.RaceStage = Constants.RaceStage.START

var was_triggered : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	was_triggered = false
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if(body is Animal):
		body.race_next_stage()
		if not was_triggered:
			was_triggered = true
			SignalBus.spawn_race_obstacles.emit(race_stage)
