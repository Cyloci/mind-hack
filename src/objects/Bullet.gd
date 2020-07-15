extends Sprite
class_name Bullet

const MOVE_SPEED = 1000

var velocity = Vector2()
var start_pos = Vector2()
var end_pos = Vector2()

func start(_start: Vector2, _end: Vector2):
	start_pos = _start
	end_pos = _end
	velocity = (_end - _start).normalized() * MOVE_SPEED
	position = _start


func _physics_process(delta):
	position += velocity * delta
	if (position - start_pos).length() > (end_pos - start_pos).length():
		queue_free()
