extends RigidBody2D
class_name Player
export var FLAP_FORCE = -340

const MAX_ROTATION_DEGREES = -5.0
signal pickup
signal die
var started = false
var alive = true
onready var animator = $AnimationPlayer


func _physics_process(delta):
	if Global.STARTED:
		if Input.is_action_just_pressed("flap") && alive:
			start()
			flap()
	if rotation_degrees <= MAX_ROTATION_DEGREES:
		angular_velocity = 0
		rotation_degrees = MAX_ROTATION_DEGREES
	if linear_velocity.y > 0:
		if rotation_degrees <= 90:
			angular_velocity = 5
		else:
			angular_velocity = 0
		
func start():
	if started: return
	started = true
	gravity_scale = 10.0
	animator.play("flap")
	
func flap():
	linear_velocity.y = FLAP_FORCE
	angular_velocity = -8
	$Wing.play()


func die():
	if !alive: return
	Global.STARTED = false
	alive = false
	animator.stop()
	$Hit.play()
	emit_signal("die")
	
