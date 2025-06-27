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
