extends MarginContainer

@onready var money_label: Label = $HBoxContainer/MoneyLabel
@onready var debt_label: RichTextLabel = $HBoxContainer/DebtLabel
@onready var borrow_button: Button = $HBoxContainer/BorrowMoneyButton

var current_money: int = 0
var current_debt: int = 0

func _ready() -> void:
	# Initialize money and debt labels
	update_money(0)
	update_debt(1000)  # Example initial debt

	# Connect signals
	SignalBus.cash_changed.connect(update_money)
	SignalBus.debt_changed.connect(update_debt)

	# Connect borrow button signal
	borrow_button.pressed.connect(_on_borrow_button_pressed)


func update_money(amount: int) -> void:
	# Update the money label with the new amount
	current_money = amount
	money_label.text = "Cash: " + str(amount)


func update_debt(amount: int) -> void:
	# Update the debt label with the new amount
	current_debt = amount
	debt_label.text = "Debt: [color=red]" + str(amount) + "[/color]"


func _on_borrow_button_pressed() -> void:
	# Handle borrowing money logic
	print("Borrow button pressed")
	current_debt += 2000  # Example logic to increase debt
	update_debt(current_debt)
