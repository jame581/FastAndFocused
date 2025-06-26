extends Node


func get_game_version() -> String:
    # Get the version from project settings
    return "v" + ProjectSettings.get_setting("application/config/version")
