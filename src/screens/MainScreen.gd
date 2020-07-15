extends Control


func _ready():
	OS.set_window_maximized(true)


func _on_SceneChangeButton_button_up():
	PlayerVariables.music.play()
	PlayerVariables.start_time = OS.get_unix_time()
