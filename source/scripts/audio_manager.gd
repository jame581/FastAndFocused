extends Node

func _ready():
	
	SignalBus.race_started.connect(handle_race_started)
	SignalBus.race_finished.connect(handle_race_finished)
	SignalBus.map_loaded.connect(handle_map_changed)
#	SignalBus.game_over.connect(handle_gameover)
	
func handle_map_changed(mapEnum: Constants.GameScenes) -> void:
	if(mapEnum == Constants.GameScenes.MAIN_MENU):
		$MainMenu.play()
	else:
		$MainMenu.stop()

func handle_race_started() -> void:
	$CrowdAudio.play()
	
func handle_race_finished(animal_finish_order) -> void:
	$CrowdAudio.stop()
	$RaceWin.play()
	
#func handle_game_over(mapEnum: Constants.GameScenes) -> void:
#	if(mapEnum == Constants.GameScenes.GAME_OVER):
#		$GameOver.play()
#	else 
#		$GameOver.stop()
	
