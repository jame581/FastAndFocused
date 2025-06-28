extends MarginContainer

@export_category("UI")
@export var betting_ui: MarginContainer

@onready var start_button: Button = $HBoxContainer/ButtonsContainer/StartRaceButton
@onready var bet_button: Button = $HBoxContainer/ButtonsContainer/BetButton
@onready var shout_button: Button = $HBoxContainer/ButtonsContainer/ShoutButton
@onready var your_bet_texture: TextureRect = $HBoxContainer/VBoxContainer/YourBetTexture

@onready var camera_switch_1: Button = $HBoxContainer/CameraSwitchContainer/HBoxContainer/Animal1Button
@onready var camera_switch_2: Button = $HBoxContainer/CameraSwitchContainer/HBoxContainer/Animal2Button
@onready var camera_switch_3: Button = $HBoxContainer/CameraSwitchContainer/HBoxContainer/Animal3Button
@onready var camera_switch_4: Button = $HBoxContainer/CameraSwitchContainer/HBoxContainer/Animal4Button

var ready_to_start: bool = false

func _ready() -> void:

	set_ready_to_start(false)	

	# Connect button signals
	start_button.pressed.connect(_on_start_button_pressed)
	bet_button.pressed.connect(_on_bet_button_pressed)
	shout_button.pressed.connect(_on_shout_button_pressed)

	# Connect camera switch signals
	camera_switch_1.pressed.connect(_on_camera_switch_1_pressed)
	camera_switch_2.pressed.connect(_on_camera_switch_2_pressed)
	camera_switch_3.pressed.connect(_on_camera_switch_3_pressed)
	camera_switch_4.pressed.connect(_on_camera_switch_4_pressed)

	print("UI ready")
	
	# Connect signals from SignalBus
	SignalBus.bet_placed.connect(handle_bet_placed)
	SignalBus.race_init.connect(handle_race_init)


func _on_start_button_pressed() -> void:
	print("Start Race button pressed")
	SignalBus.race_started.emit()
	start_button.release_focus()

func _on_bet_button_pressed() -> void:
	print("Bet button pressed")
	betting_ui.show_betting_panel()	
	set_ready_to_start(true)
	# TODO: Implement betting logic here

func set_ready_to_start(value: bool) -> void:
	ready_to_start = value
	start_button.disabled = not value
	your_bet_texture.visible = value
	bet_button.disabled = value

func _on_camera_switch_1_pressed() -> void:
	SignalBus.race_camera_switch.emit(0)

func _on_camera_switch_2_pressed() -> void:
	SignalBus.race_camera_switch.emit(1)

func _on_camera_switch_3_pressed() -> void:
	SignalBus.race_camera_switch.emit(2)

func _on_camera_switch_4_pressed() -> void:
	SignalBus.race_camera_switch.emit(3)

func handle_bet_placed(animal_id: Constants.AnimalId, bet_amount: int) -> void:
	print("Bet placed on animal: " + str(animal_id) + " with amount: " + str(bet_amount))
	your_bet_texture.texture = Constants.ANIMAL_DATA[animal_id]["icon"]
	set_ready_to_start(true)

func handle_race_init() -> void:
	print("Race initialized")

func setup_switch_camera_icons(animal_ids: Array[Constants.AnimalId]) -> void:
	# This function can be used to set up the camera switch icons based on the animal IDs
	# For now, we will just print the animal IDs
	print("Setting up camera switch icons for animals: " + str(animal_ids))
	
	# Example of setting up icons (assuming you have a method to get icon by animal ID)
	camera_switch_1.icon = Constants.ANIMAL_DATA[animal_ids[0]]["icon"]
	camera_switch_2.icon = Constants.ANIMAL_DATA[animal_ids[1]]["icon"]
	camera_switch_3.icon = Constants.ANIMAL_DATA[animal_ids[2]]["icon"]
	camera_switch_4.icon = Constants.ANIMAL_DATA[animal_ids[3]]["icon"]


func _on_shout_button_pressed() -> void:
	AudioManager.play_shout()
