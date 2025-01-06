extends Control

# Exported properties
@export var sprite_frames: Array[int] = [0]
@export var stop_audio_stream: AudioStream

signal reel_stopped()

# Nodes
@onready var fruits_panel: Node2D = $Fruits
@onready var fruit_1: Sprite2D = $Fruits/Fruit1
@onready var fruit_2: Sprite2D = $Fruits/Fruit2
@onready var fruit_3: Sprite2D = $Fruits/Fruit3
@onready var fruit_4: Sprite2D = $Fruits/Fruit4
@onready var state_machine: FiniteStateMachine = $FiniteStateMachine
@onready var stop_audio_player: AudioStreamPlayer = $StopSound

# State variables
var top_index = 0
var max_speed = 0.0
var current_speed = 0.0


func _ready():
	stop_audio_player.stream = stop_audio_stream
	top_index = randi_range(0, sprite_frames.size() - 1)
	_update_fruit()


func handle_wrap_around():
	if fruits_panel.position.y >= 0:
		fruits_panel.position.y -= 40
		top_index = (top_index - 1) % sprite_frames.size()
		_update_fruit()
		return true

	return false


func _update_fruit():
	fruit_1.frame = sprite_frames[top_index]
	fruit_2.frame = sprite_frames[(top_index + 1) % sprite_frames.size()]
	fruit_3.frame = sprite_frames[(top_index + 2) % sprite_frames.size()]
	fruit_4.frame = sprite_frames[(top_index + 3) % sprite_frames.size()]


func spin():
	max_speed = randf_range(400, 600)
	state_machine.change_state_to("Spinning")


func stop():
	state_machine.change_state_to("StopRequested")


func winning_fruit():
	sprite_frames[(top_index + 2) % sprite_frames.size()]
