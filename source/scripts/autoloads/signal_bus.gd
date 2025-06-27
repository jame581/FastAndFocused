extends Node

# Autoload script for handling signals across the game

# Game management signals
signal map_loaded(map_name: Constants.GameScenes)

# Race signals
signal race_started()
signal race_finished(winner: String)