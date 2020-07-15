extends KinematicBody2D


const MAX_FALL_SPEED = 1000
const JUMP_FORCE = 1500
const MOVE_SPEED = 400 

var _velocity = Vector2(0, 0)
var possessed = false
var cooled_down = false

func _ready() -> void:
	_velocity.x = -MOVE_SPEED

var time = 0
func _physics_process(delta: float) -> void:
	time += delta
	if possessed:
		var move_dir = 0
		if Input.is_action_pressed("ui_right"):
			move_dir += 1
		if Input.is_action_pressed("ui_left"):
			move_dir -= 1
		move_and_slide(Vector2(move_dir * MOVE_SPEED, _velocity.y), Vector2.UP)

		PlayerVariables.player.position = position + Vector2(0, -32)

		if Input.is_action_just_pressed('click') and cooled_down:
			possessed = false
			PlayerVariables.camera.current = true
			PlayerVariables.player.visible = true
			PlayerVariables.left_creature = true
			queue_free()
	else:
		_velocity.x *= -1 if is_on_wall() else 1
		move_and_slide(_velocity, Vector2.UP)
	
	position.y += sin(time * 10) * 4
	


func _on_Player_shoot(object, _start, _end):
	if object != self:
		return
	$CaptureCooldown.start()


func _on_CaptureCooldown_timeout():
	cooled_down = true
	possessed = true
	$Camera2D.current = true
	PlayerVariables.player.visible = false
