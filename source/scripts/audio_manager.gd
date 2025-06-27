extends Node

func _ready():
	
	SignalBus.race_started.connect(handle_race_started)
	SignalBus.race_finished.connect(handle_race_finished)
	
func handle_map_changed(mapEnum: Constants.GameScenes) -> void:
	if(mapEnum == Constants.GameScenes.MAIN_MENU):
		$MainMenu.play()
	if(mapEnum == Constants.GameScenes.RACE):
		$MainMenu.stop()
	else:
		$MainMenu.stop()

func handle_race_started() -> void:
	$CrowdAudio.play()
	
func handle_race_finished(winner) -> void:
	$CrowdAudio.stop()

	
