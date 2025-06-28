extends MarginContainer

@onready var main_menu_button: Button = $BettingPanel/MarginContainer/root/RightPanel/MarginContainer3/MarginContainer3/Panel/MainMenuButton
@onready var animals_result_label: RichTextLabel = $BettingPanel/MarginContainer/root/LeftPanel/MarginContainer/left/AnimalsResultLabel
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	# Initialize the game over panel
	visible = false

	SignalBus.game_over.connect(show_game_over_panel)


func _on_main_menu_button_pressed() -> void:
	SceneChanger.goto_scene(Constants.GameScenes.MAIN_MENU)


func show_game_over_panel() -> void:
	# Show the game over panel
	visible = true
	animation_player.play("fade_in")
	update_data()

func hide_game_over_panel() -> void:
	# Hide the game over panel
	animation_player.play("fade_out")


func update_data() -> void:
	# Update the game over panel with relevant data from GameManager
	var saved_animals = GameManager.saved_animals
	var killed_animals = GameManager.unsaved_animals
	
	var saved_text = "[color=\"green\"]Saved animals:"
	for animal in saved_animals:
		saved_text += "\n- " + str(animal)
	saved_text += "[/color]"
	
	var killed_text = "[color=\"red\"]Killed animals:"
	for animal in killed_animals:
		killed_text += "\n- " + animal
	killed_text += "[/color]"
	
	animals_result_label.text = saved_text + "\n" + killed_text
