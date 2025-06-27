extends MarginContainer

func _ready() -> void:
    # Initialize the betting panel
    # This panel should be hidden by default
    visible = false

    SignalBus.race_finished.connect(_on_race_finished)

    # Connect signals or set up initial state if needed
    # Example: SignalBus.betting_panel_ready.connect(_on_betting_panel_ready)

func _on_race_finished(animal_finish_order: Array[Animal]) -> void:
    visible = true
    # Update the UI with the race results