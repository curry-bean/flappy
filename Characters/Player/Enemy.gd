extends Area2D

var SPEED = Global.SPEED
func _physics_process(delta):
	position.x += -SPEED * delta
	if global_position.x <= -64:
		queue_free()

		


func _on_Enemy_body_entered(body):
	if body is Player:
		if body.has_method("die"):
			body.die()
