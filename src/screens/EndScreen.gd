extends Control


func _ready():
	PlayerVariables.has_gun = false

	var time_now = OS.get_ticks_msec()
	var elapsed = time_now - PlayerVariables.start_time
	var secs = elapsed / 1000
	var minutes = secs / 60
	var hours = minutes / 60
	var seconds = secs % 60
	var millis = elapsed % 1000
	var str_elapsed = "%02d:%02d:%02d.%03d" % [hours, minutes, seconds, millis]
	$VBoxContainer/Label.text = str_elapsed


func _on_SceneChangeButton_button_up():
	PlayerVariables.start_time = OS.get_ticks_msec()
