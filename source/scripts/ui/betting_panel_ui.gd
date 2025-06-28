extends MarginContainer

@export_category("Betting Panel")
@export var betting_amount: int = 50

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var first_lineup_button: Button = $BettingPanel/MarginContainer/root/LeftPanel/MarginContainer/left/FirstLineupButton
@onready var second_lineup_button: Button = $BettingPanel/MarginContainer/root/LeftPanel/MarginContainer/left/SecondLineupButton
@onready var third_lineup_button: Button = $BettingPanel/MarginContainer/root/LeftPanel/MarginContainer/left/ThirdLineupButton
@onready var fourth_lineup_button: Button = $BettingPanel/MarginContainer/root/LeftPanel/MarginContainer/left/FourthLineupButton

@onready var place_bet_button: Button = $BettingPanel/MarginContainer/root/RightPanel/MarginContainer3/MarginContainer/Panel/BetButton

@onready var animal_name_label: Label = $BettingPanel/MarginContainer/root/RightPanel/MarginContainer3/MarginContainer2/VBoxContainer/AnimalNameLabel
@onready var animal_icon_texture_rect: TextureRect = $BettingPanel/MarginContainer/root/RightPanel/MarginContainer3/AnimalTextureRect

@onready var first_lineup_texture_rect: TextureRect = $BettingPanel/MarginContainer/root/LeftPanel/MarginContainer/left/FirstLineupButton/HBoxContainer/FirstLineupTextureRect
@onready var second_lineup_texture_rect: TextureRect = $BettingPanel/MarginContainer/root/LeftPanel/MarginContainer/left/SecondLineupButton/HBoxContainer/SecondLineupTextureRect
@onready var third_lineup_texture_rect: TextureRect = $BettingPanel/MarginContainer/root/LeftPanel/MarginContainer/left/ThirdLineupButton/HBoxContainer/ThirdLineupTextureRect
@onready var fourth_lineup_texture_rect: TextureRect = $BettingPanel/MarginContainer/root/LeftPanel/MarginContainer/left/FourthLineupButton/HBoxContainer/FourthLineupTextureRect

@onready var first_lineup_odds: Label = $BettingPanel/MarginContainer/root/LeftPanel/MarginContainer/left/FirstLineupButton/HBoxContainer/VBoxContainer/FirstLineupOdds
@onready var second_lineup_odds: Label = $BettingPanel/MarginContainer/root/LeftPanel/MarginContainer/left/SecondLineupButton/HBoxContainer/VBoxContainer/SecondLineupOdds
@onready var third_lineup_odds: Label = $BettingPanel/MarginContainer/root/LeftPanel/MarginContainer/left/ThirdLineupButton/HBoxContainer/VBoxContainer/ThirdLineupOdds
@onready var fourth_lineup_odds: Label = $BettingPanel/MarginContainer/root/LeftPanel/MarginContainer/left/FourthLineupButton/HBoxContainer/VBoxContainer/FourthLineupOdds

var animals_lineup: Array[Constants.AnimalId] = []
var current_animal_index: int = 0

func _ready() -> void:
	# Initialize the betting panel
	# This panel should be hidden by default
	# visible = false

	# Connect signals for betting buttons
	first_lineup_button.pressed.connect(_on_first_lineup_button_pressed)
	second_lineup_button.pressed.connect(_on_second_lineup_button_pressed)
	third_lineup_button.pressed.connect(_on_third_lineup_button_pressed)
	fourth_lineup_button.pressed.connect(_on_fourth_lineup_button_pressed)

	place_bet_button.pressed.connect(place_bet)

func set_animals_lineup(lineup: Array[Animal]) -> void:
	# Set the animals lineup for betting
	for animal in lineup:
		if animal is Animal:
			animals_lineup.append(animal.id)
			print("Added animal to lineup: " + str(animal.id))
		else:
			push_error("Invalid animal in lineup: " + str(animal))

	update_lineup_textures()
	generate_odds()


func show_betting_panel() -> void:
	# Show the betting panel
	visible = true


func switch_animal(animal_index: int) -> void:
	# Switch the animal in the betting panel
	if animal_index < 0 or animal_index >= animals_lineup.size():
		push_error("Invalid animal index: " + str(animal_index))
		return
	
	current_animal_index = animal_index
	var animal_id = animals_lineup[current_animal_index]
	var animal_data = Constants.ANIMAL_DATA[animal_id]
	animal_name_label.text = animal_data["name"]
	animal_icon_texture_rect.texture = animal_data["icon"]

func place_bet() -> void:
	# Place a bet on the currently selected animal
	pass

func _on_first_lineup_button_pressed() -> void:
	switch_animal(0)

func _on_second_lineup_button_pressed() -> void:
	switch_animal(1)

func _on_third_lineup_button_pressed() -> void:
	switch_animal(2)

func _on_fourth_lineup_button_pressed() -> void:
	switch_animal(3)

func update_lineup_textures() -> void:
	# Update the textures for the lineup buttons
	if animals_lineup.size() > 0:
		first_lineup_texture_rect.texture = Constants.ANIMAL_DATA[animals_lineup[0]]["icon"]
	if animals_lineup.size() > 1:
		second_lineup_texture_rect.texture = Constants.ANIMAL_DATA[animals_lineup[1]]["icon"]
	if animals_lineup.size() > 2:
		third_lineup_texture_rect.texture = Constants.ANIMAL_DATA[animals_lineup[2]]["icon"]
	if animals_lineup.size() > 3:
		fourth_lineup_texture_rect.texture = Constants.ANIMAL_DATA[animals_lineup[3]]["icon"]


func generate_odds() -> void:
	# Generate random odds for the animals in the lineup
	var base_odds = 1.0
	
	for i in range(animals_lineup.size()):
		var odds = base_odds + randf() * 5.0  # Random odds between 1.0 and 6.0
		print("Generated odds for animal " + str(animals_lineup[i]) + ": " + str(odds))
		
		# format odds to two decimal places
		odds = round(odds * 100) / 100.0
		match i:
			0: first_lineup_odds.text = str(odds)
			1: second_lineup_odds.text = str(odds)
			2: third_lineup_odds.text = str(odds)
			3: fourth_lineup_odds.text = str(odds)


func _on_close_button_pressed() -> void:
	visible = false
