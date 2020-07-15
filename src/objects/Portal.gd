tool
extends Area2D


export var next_scene: PackedScene


func _on_Portal_body_entered(body: PhysicsBody2D):
	if body != PlayerVariables.player:
		return
	teleport()


func _get_configuration_warning() -> String:
	return "The property Next Level can't be empty" if not next_scene else ""


func _physics_process(delta):
	rotation -= 2 * delta


func teleport() -> void:
	var time_now = OS.get_ticks_msec()
	PlayerVariables.splits.append(time_now)
	get_tree().change_scene_to(next_scene)
