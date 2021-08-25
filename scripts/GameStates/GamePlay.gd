extends "res://scripts/state_machine/state.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(NodePath) var game_hud
onready var game_play = $"../../"
onready var animation_player = $"../../AnimationPlayer"
var score = 0  setget _set_game_score, _get_game_score
var error_count = 0 setget _set_game_error_count, _get_game_error_count
onready var hud = get_node(game_hud)
export(NodePath) var btn_sfx_path
onready var btn_sfx = get_node(btn_sfx_path)

export(NodePath) var pause_button_path
onready var pause_button = get_node(pause_button_path)

func _set_game_error_count(value):
	error_count = value

func _get_game_error_count():
	return error_count

func _set_game_score(value):
	score = value
	hud.get_node("HBoxContainer/ScoreValue").text = str(score)
	
func _get_game_score():
	return score
	
# Called when the node enters the scene tree for the first time.
func _ready():
	game_play.connect("target_status", self, "_on_target_status")
	reset_game()
	pass # Replace with function body.

func reset_game():
	self.score = 0
	self.error_count = 0

	
func _on_target_status(status):
	if status == game_play.cross_hair.STATUS.WRONG:
		self.error_count += 1
		if self.error_count == 1:
			emit_signal("finished", "GameOver")
		pass
	elif status == game_play.cross_hair.STATUS.RIGHT:
		self.score += 10
		pass
	elif status == game_play.cross_hair.STATUS.WARNING:
		self.score += 5
		pass
	
	if self.score % 50 == 0:
		ColorPalette.random_palette()

func enter():
	hud.visible = true
	hud.get_node("ColorRect").visible = false
	animation_player.play("show_hud")
	pass

# Clean up the state. Reinitialize values like a timer.
func exit():
	pass


func handle_input(_event):
	game_play.player.on_input(_event)


func update(_delta):
	game_play.game_process(_delta)
	pass


func _on_animation_finished(_anim_name):
	pass


func _on_PauseButton_toggled(button_pressed):
	if button_pressed:
		btn_sfx.play()
		emit_signal("finished", "Pause")
	pass # Replace with function body.
