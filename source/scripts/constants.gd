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
	AnimalId.DOG:    { "name": "Dog",     "icon": preload("uid://dhck1kstep5ij") },
	AnimalId.BEAVER: { "name": "Beaver",  "icon": preload("uid://ou0v5jgj6kxl") },
	AnimalId.GOAT:   { "name": "Goat",    "icon": preload("uid://df8nea6fxt3ot") },
	AnimalId.GIRAFFE:{ "name": "Giraffe", "icon": preload("uid://b0jwg2k4ghf0a") },
	AnimalId.KAKAPO: { "name": "Kakapo",  "icon": preload("uid://ptlloynhxaso") },
	AnimalId.RAT:    { "name": "Rat",     "icon": preload("uid://3ndqmve4wjom") },
	AnimalId.FISH:   { "name": "Fish",    "icon": preload("uid://cikat3coqaarj") },
	AnimalId.HIPPO:  { "name": "Hippo",   "icon": preload("uid://bjf7bro2bkwxg") },
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
