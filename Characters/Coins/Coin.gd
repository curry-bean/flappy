extends Area2D

var screensize
var SPEED = Global.SPEED

func pickup():
	$Point.play()
	$Tween.start()
	
func _ready():
	$Tween.interpolate_property($AnimatedSprite, 'scale',
								$AnimatedSprite.scale,
								$AnimatedSprite.scale * 3, 0.3,
								Tween.TRANS_QUAD,
								Tween.EASE_IN_OUT)
	$Tween.interpolate_property($AnimatedSprite, 'modulate',
								Color(1,1,1,1),
								Color(1,1,1,0), 0.3,
								Tween.TRANS_QUAD,
								Tween.EASE_IN_OUT)
	$Timer.wait_time = rand_range(3, 8)
	$Timer.start()



# warning-ignore:unused_argument
# warning-ignore:unused_argument
func _on_Tween_tween_completed(object: Object, key: NodePath) -> void:
	queue_free()
	
func _on_Coin_area_entered( area ):
	if area.is_in_group("obstacles"):
		queue_free()


func _on_Timer_timeout():
	$AnimatedSprite.frame = 0
	$AnimatedSprite.play()

func _physics_process(delta):
	position.x += -SPEED * delta
	if global_position.x <= -64:
		queue_free()


func _on_Coin_body_entered(body):
	if body is Player:
		pickup()
		Global.player_scored()
