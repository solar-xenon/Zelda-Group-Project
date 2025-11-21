extends Node


static var medal_amount = 0
static var enemies_killed = 0
static var key_count = 0
static var has_key = false
const REQUIRED_MEDALS = 3

func _ready():
	get_tree().connect("tree_changed", Callable(self, "_on_scene_changed"))
	

func add_kill():
	enemies_killed += 1

func check_endgame():
	if medal_amount >= REQUIRED_MEDALS:
		game_won()
	else:
		game_lost()
		
		
func game_won():
	get_tree().change_scene_to_file("res://Scenes/game_won_cutscene.tscn")
	
func game_lost():
	get_tree().change_scene_to_file("res://Scenes/game_lost_cutscene.tscn")


func reset_level():
	enemies_killed = 0
