extends MarginContainer


@onready var looser_name_label: Label = $BettingPanel/MarginContainer/root/LeftPanel/MarginContainer3/MarginContainer2/VBoxContainer/WinnerNameLabel
@onready var looser_fate_text_label: Label = $BettingPanel/MarginContainer/root/RightPanel/MarginContainer/VBoxContainer/AnimalFateLabel
@onready var cash_labels: Label = $BettingPanel/MarginContainer/root/LeftPanel/MarginContainer3/MarginContainer/Panel/CashLabel

@onready var looser_icon_texture: Label = $BettingPanel/MarginContainer/root/LeftPanel/MarginContainer3/WinnerTextureRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var next_button: Button = $BettingPanel/MarginContainer/root/RightPanel/MarginContainer3/Panel/NextButton
@onready var buy_animal_button: Button = $BettingPanel/MarginContainer/root/RightPanel/MarginContainer4/Panel/BuyAnimalButton


var closing_betting_ui: bool = false
var last_animal_id: Constants.AnimalId

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	# Connect the animation finished signal to handle UI visibility
	animation_player.animation_finished.connect(_on_animation_finished)
	
	SignalBus.race_finished.connect(_on_race_finished)
	SignalBus.cash_changed.connect(_on_cash_cahnged)
	next_button.pressed.connect(_on_next_button_pressed)
	buy_animal_button.pressed.connect(_on_buy_animal_button_pressed)
	
	buy_animal_button.disabled = !GameManager.can_afford_animal(last_animal_id)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_race_finished(animal_finish_order: Array[Animal]) -> void:
	#show_panel()

	# Clear previous results
	last_animal_id = animal_finish_order[-1].id
	
	# Update the UI with the results
	looser_name_label.text = Constants.ANIMAL_DATA[last_animal_id]["name"]
	looser_fate_text_label.text = Constants.ANIMAL_DATA[last_animal_id]["fate"]
	looser_icon_texture.texture = Constants.ANIMAL_DATA[last_animal_id]["icon"]
	cash_labels.text = "[color=\"black\"]Cash: " + str(GameManager.get_cash()) + "[/color]"

func show_panel() -> void:
	# Show the betting panel
	
	visible = true
	animation_player.play("fade_in")
	closing_betting_ui = false


func hide_panel() -> void:
	# Hide the betting panel
	closing_betting_ui = true
	animation_player.play_backwards("fade_in")

func _on_animation_finished(_anim_name: String) -> void:
	if closing_betting_ui:
		visible = false

func _on_next_button_pressed():
	hide_panel()
	SceneChanger.goto_scene(Constants.GameScenes.RACE)
	
func _on_buy_animal_button_pressed():
	buy_animal_button.disabled = true
	SignalBus.animal_saved.emit(last_animal_id)

func _on_cash_cahnged(cash: int):
	cash_labels.text = "[color=\"black\"]Cash: " + str(cash) + "[/color]"
