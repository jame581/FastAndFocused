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

const ANIMAL_DATA = {
	AnimalId.DOG:    { "name": "Dog",     "icon": "uid://dhck1kstep5ij" },
	AnimalId.BEAVER: { "name": "Beaver",  "icon": "uid://ou0v5jgj6kxl" },
	AnimalId.GOAT:   { "name": "Goat",    "icon": "uid://df8nea6fxt3ot" },
	AnimalId.GIRAFFE:{ "name": "Giraffe", "icon": "uid://b0jwg2k4ghf0a" },
	AnimalId.KAKAPO: { "name": "Kakapo",  "icon": "uid://ptlloynhxaso" },
	AnimalId.RAT:    { "name": "Rat",     "icon": "uid://3ndqmve4wjom" },
	AnimalId.FISH:   { "name": "Fish",    "icon": "uid://cikat3coqaarj" },
	AnimalId.HIPPO:  { "name": "Hippo",   "icon": "uid://bjf7bro2bkwxg" },
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
