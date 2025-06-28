extends MarginContainer

@export_category("UI")
@export var save_animal_ui: MarginContainer

@onready var winner_label: Label = $BettingPanel/MarginContainer/root/RightPanel/MarginContainer3/MarginContainer2/VBoxContainer/WinnerNameLabel
@onready var winner_texture: TextureRect = $BettingPanel/MarginContainer/root/RightPanel/MarginContainer3/WinnerTextureRect
@onready var result_label: RichTextLabel = $BettingPanel/MarginContainer/root/RightPanel/MarginContainer3/MarginContainer/Panel/ResultLabel

@onready var first_place_name_label: Label = $BettingPanel/MarginContainer/root/LeftPanel/MarginContainer/left/Result1/HBoxContainer/FirstPlaceNameLabel
@onready var second_place_name_label: Label = $BettingPanel/MarginContainer/root/LeftPanel/MarginContainer/left/Result2/HBoxContainer/SecondPlaceNameLabel
@onready var third_place_name_label: Label = $BettingPanel/MarginContainer/root/LeftPanel/MarginContainer/left/Result3/HBoxContainer/ThirdPlaceNameLabel
@onready var fourth_place_name_label: Label = $BettingPanel/MarginContainer/root/LeftPanel/MarginContainer/left/Result4/HBoxContainer/FourthPlaceNameLabel

@onready var first_place_texture: TextureRect = $BettingPanel/MarginContainer/root/LeftPanel/MarginContainer/left/Result1/HBoxContainer/FirstPlaceTextureRect
@onready var second_place_texture: TextureRect = $BettingPanel/MarginContainer/root/LeftPanel/MarginContainer/left/Result2/HBoxContainer/SecondPlaceTextureRect
@onready var third_place_texture: TextureRect = $BettingPanel/MarginContainer/root/LeftPanel/MarginContainer/left/Result3/HBoxContainer/ThirdPlaceTextureRect
@onready var fourth_place_texture: TextureRect = $BettingPanel/MarginContainer/root/LeftPanel/MarginContainer/left/Result4/HBoxContainer/FourthPlaceTextureRect

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var animals_race_result: Array[Constants.AnimalId] = []

var closing_betting_ui: bool = false


func _ready() -> void:
	# Initialize the betting panel
	# This panel should be hidden by default
	visible = false

	SignalBus.race_finished.connect(_on_race_finished)

	# Connect the animation finished signal to handle UI visibility
	animation_player.animation_finished.connect(_on_animation_finished)


func _on_race_finished(animal_finish_order: Array[Animal]) -> void:
	visible = true
	closing_betting_ui = false
	animation_player.play("fade_in")

	# Clear previous results
	animals_race_result.clear()
	
	# Process the finish order and populate the results
	for animal in animal_finish_order:
		if animal is Animal:
			animals_race_result.append(animal.id)

	# Update the UI with the results
	if animals_race_result.size() > 3:
		first_place_name_label.text = Constants.ANIMAL_DATA[animals_race_result[0]]["name"]
		first_place_texture.texture = Constants.ANIMAL_DATA[animals_race_result[0]]["icon"]

		second_place_name_label.text = Constants.ANIMAL_DATA[animals_race_result[1]]["name"]
		second_place_texture.texture = Constants.ANIMAL_DATA[animals_race_result[1]]["icon"]

		third_place_name_label.text = Constants.ANIMAL_DATA[animals_race_result[2]]["name"]
		third_place_texture.texture = Constants.ANIMAL_DATA[animals_race_result[2]]["icon"]

		fourth_place_name_label.text = Constants.ANIMAL_DATA[animals_race_result[3]]["name"]
		fourth_place_texture.texture = Constants.ANIMAL_DATA[animals_race_result[3]]["icon"]

	winner_label.text = Constants.ANIMAL_DATA[animals_race_result[0]]["name"]
	winner_texture.texture = Constants.ANIMAL_DATA[animals_race_result[0]]["icon"]

	# Check if the player won or lost money
	if GameManager.last_bet_animal_id == animals_race_result[0]:
		# Player won
		result_label.text = "[color=\"green\"]You won money! Cash remain: " + str(GameManager.get_cash()) + "[/color]"
	else:
		result_label.text = "[color=\"red\"]You lost money! Cash remain: " + str(GameManager.get_cash()) + "[/color]"

func show_betting_panel() -> void:
	# Show the betting panel
	
	visible = true
	animation_player.play("fade_in")
	closing_betting_ui = false


func hide_betting_panel() -> void:
	# Hide the betting panel
	closing_betting_ui = true
	animation_player.play_backwards("fade_in")



func _on_animation_finished(_anim_name: String) -> void:
	if closing_betting_ui:
		visible = false


func _on_next_button_pressed() -> void:
	hide_betting_panel()
	if save_animal_ui:
		save_animal_ui.show_panel()
	else:
		SceneChanger.goto_scene(Constants.GameScenes.RACE)
