extends Control


func _ready():
	OS.set_window_maximized(true)


func _on_SceneChangeButton_button_up():
	if PlayerVariables.first_run:
		PlayerVariables.music.play()
		PlayerVariables.first_run = false
	PlayerVariables.start_time = OS.get_ticks_msec()
