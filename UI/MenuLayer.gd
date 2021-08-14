extends CanvasLayer

signal start_game
var game_started = false
onready var start_message = $StartMenu/StartMessage
onready var tween = $Tween
onready var score_label = $GameOverMenu/VBoxContainer/ScoreLabel
onready var highscore_label = $GameOverMenu/VBoxContainer/HighScoreLabel
onready var game_over_menu = $GameOverMenu


func init_game_over_menu(score, highscore):
	score_label.text = "SCORE: " + str(score)
	highscore_label.text = "BEST: " + str(highscore)
	game_over_menu.visible = true
	
func _on_RestartButton_pressed():
	get_tree().reload_current_scene()


func _on_Start_pressed():
	emit_signal("start_game")
	Global.STARTED = true
	tween.interpolate_property(start_message, "modulate:a", 1, 0, 0.5)
	tween.start()
	game_started = true	
	$StartMenu/Start.hide()
