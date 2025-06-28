extends Node

class_name Constants

enum GameScenes
{
	UNKNOWN,
	MAIN_MENU,
	RACE
}

const MAPS = {
	GameScenes.MAIN_MENU: "uid://df73yks3fka5u",
	GameScenes.RACE: "uid://cdbkg4q3myof1"
}

const BET_AMOUNT: int = 50

const ANIMAL_DATA = {
	AnimalId.DOG:    { 
		"name": "Dog",
		"icon": preload("uid://dhck1kstep5ij"),
		"cost": 50,
		"fate": "A nice Korean restaurant is offering quite a sum for this dogo. You should try their Kimchi." 
		},
	AnimalId.BEAVER: {
		"name": "Beaver",
		"icon": preload("uid://ou0v5jgj6kxl"),
		"cost": 50,
		"fate": "Salt mines in bolivia believe it or not. Children are getting too expensive these days."
		},
	AnimalId.GOAT:   {
		"name": "Goat",
		"icon": preload("uid://df8nea6fxt3ot"),
		"cost": 50,
		"fate": "Local petting ZOO is looking forward to feeding this goat to their favourite lion named Alex."
		},
	AnimalId.GIRAFFE:{
		"name": "Giraffe",
		"icon": preload("uid://b0jwg2k4ghf0a"),
		"cost": 50,
		"fate": "Local extreme climber will buy this giraffe to be the first person to climb all the way up on it."
		},
	AnimalId.KAKAPO: {
		"name": "Kakapo",
		"icon": preload("uid://ptlloynhxaso"),
		"cost": 50,
		"fate": "Harry Blackbeard, half wizard, half pirate, will buy this one to be his half parrot, half owl."
		},
	AnimalId.RAT:    {
		"name": "Rat",
		"icon": preload("uid://3ndqmve4wjom"),
		"cost": 50,
		"fate": "The institute for highly experimental drugs. And snake shops all under the same corporate umbrella."
		},
	AnimalId.FISH:   {
		"name": "Fish",
		"icon": preload("uid://cikat3coqaarj"),
		"cost": 50,
		"fate": "Will be bought by a nice urban family as a pet, but one thing is certain, the wheels are coming off and the days of exploration are numbered."
		},
	AnimalId.HIPPO:  {
		"name": "Hippo",\
		"icon": preload("uid://bjf7bro2bkwxg"),
		"cost": 50,
		"fate": "Organs. You wouldn't believe how much the hippo organs go for on the black market."
		},
}

enum AnimalId {
	DOG,
	BEAVER,
	GOAT,
	GIRAFFE,
	KAKAPO,
	RAT,
	FISH,
	HIPPO	
}

enum ObstacleEnum {
	NONE,
	SAND_CASTLE,
	HONEY,
	FREE_HUGS,
	BRICS,
	BATTERY,
	SWEATER
}

enum RaceStage {
	UNKNOWN,
	START,
	MIDDLE,
	FINISH
}
