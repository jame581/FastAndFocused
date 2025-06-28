extends Control

# UI Components
@onready var start_button: Button = $MarginContainer/VBoxContainer/HBoxContainer/RightVBoxContainer/MainMenuButtons/StartButton
@onready var credit_button: Button = $MarginContainer/VBoxContainer/HBoxContainer/RightVBoxContainer/MainMenuButtons/CreditsButton
@onready var exit_button: Button = $MarginContainer/VBoxContainer/HBoxContainer/RightVBoxContainer/MainMenuButtons/ExitButton
@onready var credits_ui: MarginContainer = $CreditsUI

func _ready() -> void:
	# Connect button signals
	start_button.pressed.connect(_on_start_button_pressed)
	credit_button.pressed.connect(_on_credit_button_pressed)
	exit_button.pressed.connect(_on_exit_button_pressed)

	credits_ui.visible = false

	# Set the version text
	var version_label: Label = $MarginContainer/VBoxContainer/HBoxContainer/RightVBoxContainer/VersionLabel
	version_label.text = Global.get_game_version()


func _on_start_button_pressed() -> void:
	print("Start button pressed!")
	SceneChanger.goto_scene(Constants.GameScenes.RACE)


func _on_credit_button_pressed() -> void:
	print("Credits button pressed!")
	credits_ui.show_panel()
	

func _on_exit_button_pressed() -> void:
	print("Exit button pressed!")
	get_tree().quit()  # Exit the game