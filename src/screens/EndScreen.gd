extends Control

func millis_to_str(elapsed):
	var secs = elapsed / 1000
	var minutes = secs / 60
	var hours = minutes / 60
	var seconds = secs % 60
	var millis = elapsed % 1000
	return "%02d:%02d:%02d.%03d" % [hours, minutes, seconds, millis]


func get_splits():
	var splits_tmp = PlayerVariables.splits.duplicate()
	splits_tmp.push_front(PlayerVariables.start_time)
	var splits = []
	for i in range(splits_tmp.size() - 1):
		var split = splits_tmp[i]
		var split_diff = splits_tmp[i + 1] - splits_tmp[i]
		splits.append(split_diff)
	return splits


func splits_to_str(arr):
	var output = "";
	for s in arr:
		output += millis_to_str(s) + '\n'
	return output


func _ready():
	PlayerVariables.has_gun = false
	var time_now = OS.get_ticks_msec()
	var elapsed = time_now - PlayerVariables.start_time
	var elapsed_str = millis_to_str(elapsed)
	var splits_str = splits_to_str(get_splits())
	$VBoxContainer/Label.text = "Splits:\n%s\n\nTotal Time:\n%s" % [splits_str, elapsed_str]


func _on_SceneChangeButton_button_up():
	PlayerVariables.start_time = OS.get_ticks_msec()
