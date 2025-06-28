extends Node

func _ready():
	
	SignalBus.race_started.connect(handle_race_started)
	SignalBus.race_finished.connect(handle_race_finished)
	SignalBus.map_loaded.connect(handle_map_changed)
	SignalBus.animal_triggered_obstacle.connect(handle_animal_trigger)
#	SignalBus.game_over.connect(handle_gameover)
	
func handle_map_changed(mapEnum: Constants.GameScenes) -> void:
	if mapEnum == Constants.GameScenes.MAIN_MENU:
		$MainMenu.play()
	else:
		$MainMenu.stop()
		$CrowdAudio.play()
		$CrowdAudio.volume_db = -10

func handle_race_started() -> void:
	$CrowdAudio.volume_db = +6
	$RaceBackground.play()
	
func handle_race_finished(animal_finish_order) -> void:
	$CrowdAudio.stop()
	$RaceBackground.stop()
	$RaceWin.play()
	
func handle_animal_trigger (animalId: Constants.AnimalId, obstacle_enum: Constants.ObstacleEnum) -> void:
	if obstacle_enum == Constants.ObstacleEnum.NONE:
		return
		
	if animalId == Constants.AnimalId.DOG:
		$AnimalDog.play()
	elif animalId == Constants.AnimalId.BEAVER:
		if randi() %2 == 0:
			$AnimalBobr.play()
		else:
			$AnimalBobr2.play()
	elif animalId == Constants.AnimalId.GOAT:
		if randi() %2 == 0:
			$AnimalGoat.play() 
		else:
			$AnimalGoat2.play()
	elif animalId == Constants.AnimalId.GIRAFFE:
		$AnimalGiraffe.play()
	elif animalId == Constants.AnimalId.KAKAPO:
		$AnimalKakapo.play()
	elif animalId == Constants.AnimalId.RAT:
		$AnimalRat.play()
	elif animalId == Constants.AnimalId.FISH:
		$AnimalFish.play()
	elif animalId == Constants.AnimalId.HIPPO:
		$AnimalHippo.play()
	
	
#func handle_game_over(mapEnum: Constants.GameScenes) -> void:
#	if(mapEnum == Constants.GameScenes.GAME_OVER):
#		$GameOver.play()
#	else 
#		$GameOver.stop()
	
