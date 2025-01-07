extends MachineState

var initial_y: float
var elapsed_time: float

const TOTAL_TIME = 0.3


func enter() -> void:
	initial_y = FSM.reel.fruits_panel.position.y
	elapsed_time = 0.0


func exit(_next_state: MachineState) -> void:
	FSM.reel._on_stop()


func update(_delta: float):
	elapsed_time += _delta
	FSM.reel.fruits_panel.position.y = Tween.interpolate_value(
		initial_y,
		initial_y * -1,
		elapsed_time,
		TOTAL_TIME,
		Tween.TransitionType.TRANS_ELASTIC,
		Tween.EaseType.EASE_OUT
	)

	if elapsed_time >= TOTAL_TIME:
		FSM.reel.fruits_panel.position.y = 0
		FSM.reel.current_speed = 0.0
		FSM.reel.handle_wrap_around()
		FSM.change_state_to("Stopped")
