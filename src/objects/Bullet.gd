extends Line2D
class_name Bullet

var alpha = 1


func start(_start: Vector2, _end: Vector2):
	add_point(_start)
	add_point(_end)


func _ready():
	set_process(true)

func _process(delta):
	alpha -= 1 * delta
	modulate.a = alpha
