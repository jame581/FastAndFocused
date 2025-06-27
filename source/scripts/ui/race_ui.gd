extends MarginContainer

@onready var start_button: Button = $HBoxContainer/ButtonsContainer/StartRaceButton
@onready var bet_button: Button = $HBoxContainer/ButtonsContainer/BetButton

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
	
	# Connect camera switch signals
	camera_switch_1.pressed.connect(_on_camera_switch_1_pressed)
	camera_switch_2.pressed.connect(_on_camera_switch_2_pressed)
	camera_switch_3.pressed.connect(_on_camera_switch_3_pressed)
	camera_switch_4.pressed.connect(_on_camera_switch_4_pressed)

	print("UI ready")


func _on_start_button_pressed() -> void:
	print("Start Race button pressed")
	SignalBus.race_started.emit()

func _on_bet_button_pressed() -> void:
	print("Bet button pressed")
	set_ready_to_start(true)
	# TODO: Implement betting logic here

func set_ready_to_start(value: bool) -> void:
	ready_to_start = value
	start_button.disabled = not value

func _on_camera_switch_1_pressed() -> void:
	SignalBus.race_camera_switch.emit(0)

func _on_camera_switch_2_pressed() -> void:
	SignalBus.race_camera_switch.emit(1)

func _on_camera_switch_3_pressed() -> void:
	SignalBus.race_camera_switch.emit(2)

func _on_camera_switch_4_pressed() -> void:
	SignalBus.race_camera_switch.emit(3)
