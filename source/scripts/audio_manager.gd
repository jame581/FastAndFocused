extends Node

func _ready():
	
	SignalBus.race_started.connect(handle_race_started)
	SignalBus.race_finished.connect(handle_race_finished)
	SignalBus.map_loaded.connect(handle_map_changed)
	
func handle_map_changed(mapEnum: Constants.GameScenes) -> void:
	if(mapEnum == Constants.GameScenes.MAIN_MENU):
		$MainMenu.play()
	else:
		$MainMenu.stop()

func handle_race_started() -> void:
	$CrowdAudio.play()
	
func handle_race_finished(winner) -> void:
	$CrowdAudio.stop()

	
