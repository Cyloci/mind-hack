extends Control


func _ready():
	PlayerVariables.has_gun = false

	var time_now = OS.get_unix_time()
	var elapsed = time_now - PlayerVariables.start_time
	var minutes = elapsed / 60
	var seconds = elapsed % 60
	var str_elapsed = "%02d : %02d" % [minutes, seconds]
	$VBoxContainer/Label.text = str_elapsed


func _on_SceneChangeButton_button_up():
	PlayerVariables.start_time = OS.get_unix_time()
