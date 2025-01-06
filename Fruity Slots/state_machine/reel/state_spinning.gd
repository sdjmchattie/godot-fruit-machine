extends MachineState


func update(_delta: float):
	FSM.reel.current_speed = lerp(FSM.reel.current_speed, FSM.reel.max_speed, 0.05)
	FSM.reel.fruits_panel.position.y += FSM.reel.current_speed * _delta

	FSM.reel.handle_wrap_around()
