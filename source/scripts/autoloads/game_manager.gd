extends Node

@export var cash: int = 200
@export var bets = {}

var saved_animals: Array[Constants.AnimalId]
var unsaved_animals: Array[Constants.AnimalId]

var last_bet_animal_id: Constants.AnimalId

func _ready() -> void:
	SignalBus.bet_placed.connect(_handle_bet_placed)
	SignalBus.race_finished.connect(_handle_race_finished)
	SignalBus.animal_saved.connect(_handle_animal_saved)

func is_animal_saved(animal_id: Constants.AnimalId) -> bool:
	return saved_animals.has(animal_id)

func is_animal_unsaved(animal_id: Constants.AnimalId) -> bool:
	return unsaved_animals.has(animal_id)

func can_animal_race(animal_id: Constants.AnimalId) -> bool:
	return !is_animal_saved(animal_id) and !is_animal_unsaved(animal_id)

func number_of_out_of_race_animals() -> int:
	return saved_animals.size() + unsaved_animals.size()

func can_afford_animal(animal_id: Constants.AnimalId) -> bool:
	var animal_cost: int = Constants.ANIMAL_DATA[animal_id]["cost"]
	return animal_cost <= cash

func _handle_bet_placed(animal_id: Constants.AnimalId, bet_amount: int):
	if cash < bet_amount:
		SignalBus.game_over.emit()
		return
	
	last_bet_animal_id = animal_id

	if bets.has(animal_id):
		bets[animal_id] += bet_amount
	else:
		bets[animal_id] = bet_amount
	cash -= bet_amount
	SignalBus.cash_changed.emit(cash)

func _handle_race_finished(animal_finish_order: Array[Animal]):
	if	bets.has(animal_finish_order[0].id):
		cash += 2 * bets[animal_finish_order[0].id]
	if	bets.has(animal_finish_order[1].id):
		cash += bets[animal_finish_order[1].id]	
	SignalBus.cash_changed.emit(cash)
	
	unsaved_animals.append(animal_finish_order[-1].id)
	bets.clear()
	
	if	cash < Constants.BET_AMOUNT:
		SignalBus.game_over.emit()

func _handle_animal_saved(animal_id: Constants.AnimalId):
	var animal_cost: int = Constants.ANIMAL_DATA[animal_id]["cost"]
	if	animal_cost > cash:
		return
	if	!saved_animals.has(animal_id):
		unsaved_animals.filter(func(item): return item != animal_id) # remove animal_id from unsafed animals
		saved_animals.append(animal_id)
		cash -= animal_cost
		SignalBus.cash_changed.emit(cash)

func get_cash() -> int:
	return cash
