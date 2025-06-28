extends Node

# Autoload script for handling signals across the game

# Game management signals
signal map_loaded(map_name: Constants.GameScenes)
signal game_over()


# Race signals
signal race_init()
signal race_started()
signal animal_finished(animal: Animal)
signal race_finished(animal_finish_order: Array[Animal])
signal race_camera_switch(animal_index: int)
signal spawn_race_obstacles(race_stage: Constants.RaceStage)
signal animal_triggered_obstacle(animalId: Constants.AnimalId, obstacle_enum: Constants.ObstacleEnum)
signal bet_placed(animal_id: Constants.AnimalId, bet_amount: int)

# UI signals
signal cash_changed(new_cash: int)
signal debt_changed(new_debt: int)
