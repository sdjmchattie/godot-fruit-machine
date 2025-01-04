extends Control

# Exported properties
@export var sprite_frames: Array[int] = [0]
@export var scroll_speed := 300

# Nodes
@onready var fruits_panel: Node2D = $Fruits
@onready var fruit_1: Sprite2D = $Fruits/Fruit1
@onready var fruit_2: Sprite2D = $Fruits/Fruit2
@onready var fruit_3: Sprite2D = $Fruits/Fruit3
@onready var fruit_4: Sprite2D = $Fruits/Fruit4

# State variables
var top_index = 0
var current_speed = 0

func _ready():
	top_index = randi_range(0, sprite_frames.size() - 1)
	update_fruit()

func _process(delta):
	# Move the fruits panel downwards
	fruits_panel.position.y += scroll_speed * delta

	# Rewrap the panel once it moves too far down
	if fruits_panel.position.y >= 0:
		fruits_panel.position.y -= 40
		top_index = (top_index - 1) % sprite_frames.size()
		update_fruit()

func winning_fruit():
	sprite_frames[(top_index + 2) % sprite_frames.size()]

func update_fruit():
	fruit_1.frame = sprite_frames[top_index]
	fruit_2.frame = sprite_frames[(top_index + 1) % sprite_frames.size()]
	fruit_3.frame = sprite_frames[(top_index + 2) % sprite_frames.size()]
	fruit_4.frame = sprite_frames[(top_index + 3) % sprite_frames.size()]
