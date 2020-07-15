extends Node


var has_gun = false
var camera: Camera2D
var player: KinematicBody2D
var music: AudioStreamPlayer = AudioStreamPlayer.new()
var poison_resistant: bool = false
var left_creature: bool = false
var start_time
var first_run = true
var splits = []


func _ready():
	add_child(music)
	music.stream = preload("res://assets/music.wav")
