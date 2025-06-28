extends MarginContainer

@export var return_focus_on_close: Button

@onready var close_button: Button = $BettingPanel/MarginContainer/root/Panel/MarginContainer3/MarginContainer3/Panel/CloseButton
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var closing_ui: bool = false


func _ready() -> void:
	visible = false
	animation_player.animation_finished.connect(_on_animation_finished)


func show_panel() -> void:
	visible = true
	animation_player.play("fade_in")
	closing_ui = false
	close_button.grab_focus()


func hide_panel() -> void:
	closing_ui = true
	animation_player.play_backwards("fade_in")

	if return_focus_on_close:
		# If a button is specified, focus it when the panel closes
		return_focus_on_close.grab_focus()


func _on_animation_finished(_anim_name: String) -> void:
	if closing_ui:
		visible = false

func _on_close_button_pressed() -> void:
	hide_panel()
