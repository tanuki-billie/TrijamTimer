extends Control

@onready var timer : Timer = $TrijamTimer
@onready var stopwatch_label : Label = %Stopwatch
@onready var stopwatch_ms_label : Label = %StopwatchMS

@onready var timer_control_button : Button = %TimerControl

const THREE_HOURS_IN_SECONDS : float = 10800.0

func _ready() -> void:
	update_labels(THREE_HOURS_IN_SECONDS)
	
func _process(delta):
	if not timer.is_stopped():
		update_labels(timer.time_left)
	
func update_labels(time_left: float) -> void:
	var seconds := floorf(fmod(time_left, 60.0))
	var minutes := floorf(fmod(time_left / 60, 60.0))
	var hours := floorf(time_left / 3600.0)
	
	var ms := (time_left - floorf(time_left)) * 1000.0
	
	stopwatch_label.text = "%02d:%02d:%02d" % [hours, minutes, seconds]
	stopwatch_ms_label.text = "%03d" % ms

func control_timer() -> void:
	if not timer.is_stopped():
		toggle_timer()
	else:
		start_timer()
		
func toggle_timer() -> void:
	timer.paused = not timer.paused
	update_timer_control_button()

func reset_timer() -> void:
	timer.paused = false
	timer.stop()
	update_labels(THREE_HOURS_IN_SECONDS)
	update_timer_control_button()

func start_timer() -> void:
	timer.start(THREE_HOURS_IN_SECONDS)
	update_timer_control_button()

func update_timer_control_button() -> void:
	timer_control_button.text = tr("Start") if timer.paused or timer.is_stopped() else tr("Pause")
