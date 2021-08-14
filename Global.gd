extends Node

const SAVE_FILE_PATH = "user://savedata.save"

var SPEED = 200
var SCORE = 0
var HIGHSCORE = 0
var STARTED = false

func increase_speed():
	SPEED += 20

func player_scored():
	SCORE += 10

func save_highscore():
	var save_data = File.new()
	save_data.open(SAVE_FILE_PATH, File.WRITE)
	save_data.store_var(HIGHSCORE)
	save_data.close()
	
func load_highscore():
	var save_data = File.new()
	if save_data.file_exists(SAVE_FILE_PATH):
		save_data.open(SAVE_FILE_PATH, File.READ)
		HIGHSCORE = save_data.get_var()
		save_data.close()
