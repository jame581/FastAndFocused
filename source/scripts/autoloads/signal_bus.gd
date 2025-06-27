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

# UI signals
signal cash_changed(new_cash: int)
signal debt_changed(new_debt: int)
