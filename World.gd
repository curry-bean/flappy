extends Node2D
signal increase
onready var hud = $HUD
export (PackedScene) var Xalimos
export (PackedScene) var Coins
onready var menu_layer = $MenuLayer

func _ready():
	Global.load_highscore()
	
	
	
func new_game():
	$Timer.start()
	$SpeedTimer.start()
	$CoinTimer.start()
	Global.SCORE = 0
	Global.SPEED = 200
	
	
func _on_Timer_timeout():
	randomize()
	var d = Xalimos.instance()
	$XalimoContainer.add_child(d)
	d.position = Vector2(500, rand_range(42, 650))



func _process(delta):
	hud.update_score(Global.SCORE)


func _on_SpeedTimer_timeout():
	Global.increase_speed()


func _on_CoinTimer_timeout():
	randomize()
	var c = Coins.instance()
	$CoinContainer.add_child(c)
	c.position = Vector2(500, rand_range(42, 650))


func _on_DeathZone_body_entered(body):
	if body is Player:
		if body.has_method("die"):
			body.die()


func _on_Player_die():
	game_over()
	
func game_over():
	$Timer.stop()
	$CoinTimer.stop()
	$SpeedTimer.stop()
	$Ground/AnimationPlayer.stop()
	get_tree().call_group("obstacles", "set_physics_process", false)
	get_tree().call_group("coins", "set_physics_process", false)
	if Global.SCORE > Global.HIGHSCORE:
		Global.HIGHSCORE = Global.SCORE
		Global.save_highscore()
	menu_layer.init_game_over_menu(Global.SCORE, Global.HIGHSCORE)

func _on_MenuLayer_start_game():
	new_game()
