extends MachineState


func update(_delta: float):
	FSM.reel.fruits_panel.position.y += FSM.reel.current_speed * _delta
	if FSM.reel.handle_wrap_around():
		FSM.change_state_to("Slowing")
