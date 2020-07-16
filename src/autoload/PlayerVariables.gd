extends Node


var camera: Camera2D
var player: KinematicBody2D
var music: AudioStreamPlayer = AudioStreamPlayer.new()
var first_run = true
var poison_resistant: bool = false
var left_creature: bool = false
var start_time
var splits = []
var has_gun = false


func reset():
	start_time = OS.get_ticks_msec()
	splits = []
	has_gun = false
	left_creature = false
	# Can't reset poison_resistant because it became a speedrun strat
	# Thanks, pixel
	# poison_resistant = false


func _ready():
	add_child(music)
	music.stream = preload("res://assets/music.wav")
