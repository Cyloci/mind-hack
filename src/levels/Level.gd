extends Node2D
class_name Level

var Bullet = preload("res://src/objects/Bullet.tscn")

func _on_Player_shoot(_object, start, end):
	var b = Bullet.instance()
	add_child(b)
	b.start(start, end)
