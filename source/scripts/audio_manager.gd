extends Node

func _ready():
	
	SignalBus.race_started.connect(handle_race_started)
	SignalBus.race_finished.connect(handle_race_finished)


func handle_race_started() -> void:
	$CrowdAudio.play()
	
func handle_race_finished(winner) -> void:
	$CrowdAudio.stop()
