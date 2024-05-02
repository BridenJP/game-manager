extends Node2D

enum GAME_STATE {Start, Playing, GameOver, Completed}

const MAX_LEVELS: int = 2

var state: GAME_STATE
var level: int
var level_node: Node # Our placeholder node where we will put the level scene
var current_level: Level # The currently loaded level scene

var score: int
var time_left: int

func _ready() -> void:
	level_node = $Playing/Level
	set_state(GAME_STATE.Start)

func set_state(new_state: GAME_STATE) -> void:
	state = new_state
	$Overlay/StartScreen.visible = state == GAME_STATE.Start
	$Overlay/GameOver.visible = state == GAME_STATE.GameOver
	$Overlay/Completed.visible = state == GAME_STATE.Completed
	$Playing.visible = state == GAME_STATE.Playing
	$Playing/HUD.visible = state == GAME_STATE.Playing
	level_node.visible = state == GAME_STATE.Playing

func _on_start_screen_start_button_pressed() -> void:
	score = 0
	goto_level(1)
	set_state(GAME_STATE.Playing)
	
func free_level() -> void:
	if current_level:
		current_level.queue_free()
		current_level = null

func goto_level(new_level: int) -> void:
	free_level()

	level = new_level

	var path: String = "res://levels/level" + str(level) + ".tscn"
	current_level = load(path).instantiate()
	current_level.connect("score_changed", _on_score_changed)
	current_level.connect("level_cleared", _on_level_cleared)
	level_node.add_child(current_level)
	
	set_time_left(current_level.get_time_limit())
	$LevelTimer.start()
	
func set_time_left(t: int) -> void:	
	time_left = t
	$Playing/HUD/TimerLabel.text = str(time_left)
	if time_left <= 0:
		set_state(GAME_STATE.GameOver)
	
func _on_score_changed(points: int) -> void:
	score += points
	$Playing/HUD.show_score(score)
	
func _on_level_cleared() -> void:
	level += 1
	if level <= MAX_LEVELS:
		goto_level(level)
	else:
		set_state(GAME_STATE.Completed)

func _on_level_timer_timeout() -> void:
	set_time_left(time_left - 1)
