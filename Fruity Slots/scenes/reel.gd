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
@onready var stop_audio_player: AudioStreamPlayer = $StopSound

enum State { STOPPED, SPINNING, SLOWING, SETTLING }

# State variables
var state = State.STOPPED
var top_index = 0
var max_speed = 0.0
var current_speed = 0.0

func _ready():
	stop_audio_player.stream = stop_audio_stream
	top_index = randi_range(0, sprite_frames.size() - 1)
	_update_fruit()

func _process(delta):
	# Change speed
	match state:
		State.STOPPED:
			current_speed = 0.0
		State.SPINNING:
			current_speed = lerp(current_speed, max_speed, 0.05)
		State.SLOWING:
			current_speed = lerp(current_speed, 0.0, 0.35)
			if current_speed < 50.1:
				state = State.SETTLING

	if state == State.SETTLING:
		fruits_panel.position.y = lerp(fruits_panel.position.y, -40.0, 0.35)
		if fruits_panel.position.y < -39.9:
			state = State.STOPPED
			stop_audio_player.play()
			reel_stopped.emit()
	else:
		fruits_panel.position.y += current_speed * delta

	# Rewrap the panel once it moves too far down
	if fruits_panel.position.y >= 0:
		fruits_panel.position.y -= 40
		top_index = (top_index - 1) % sprite_frames.size()
		_update_fruit()

func _update_fruit():
	fruit_1.frame = sprite_frames[top_index]
	fruit_2.frame = sprite_frames[(top_index + 1) % sprite_frames.size()]
	fruit_3.frame = sprite_frames[(top_index + 2) % sprite_frames.size()]
	fruit_4.frame = sprite_frames[(top_index + 3) % sprite_frames.size()]

func spin():
	max_speed = randf_range(400, 600)
	state = State.SPINNING

func stop():
	state = State.SLOWING

func winning_fruit():
	sprite_frames[(top_index + 2) % sprite_frames.size()]
