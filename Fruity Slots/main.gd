extends Node2D

@onready var reels: Node2D = $Reels
@onready var reel_1 = $Reels/Reel1
@onready var reel_2 = $Reels/Reel2
@onready var reel_3 = $Reels/Reel3
@onready var reel_timer: Timer = $ReelTimer

func _on_start_pressed() -> void:
	for reel in reels.get_children():
		reel.spin()
	reel_timer.start()

func _on_reel_timer_timeout() -> void:
	reel_timer.stop()
	reels.get_child(0).stop()
	await get_tree().create_timer(0.4).timeout
	reels.get_child(1).stop()
	await get_tree().create_timer(0.4).timeout
	reels.get_child(2).stop()

func _on_reel_stopped() -> void:
	pass # Replace with function body.
