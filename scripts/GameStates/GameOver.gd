extends "res://scripts/state_machine/state.gd"

export(NodePath) var game_over_path
onready var game_over = get_node(game_over_path)
onready var animation_player = $"../../AnimationPlayer"

export(NodePath) var btn_sfx_path
onready var btn_sfx = get_node(btn_sfx_path)

export(NodePath) var score_label_path
onready var score_label = get_node(score_label_path)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func enter():
	game_over.visible = true
	score_label.text = "Score:" + str($"../GamePlay".score)
	animation_player.play("show_game_over")
	pass

# Clean up the state. Reinitialize values like a timer.
func exit():
	game_over.visible = false
	pass


func handle_input(_event):
	pass


func update(_delta):
	pass


func _on_animation_finished(_anim_name):
	
	if _anim_name == "hide_game_over" and animation_player.get_playing_speed() < 1:
		$"../GamePlay".reset_game()
		owner.player.rot_speed = 2
		emit_signal("finished", "GamePlay")
	pass


func _on_ReplayButton_pressed():
	animation_player.play_backwards("show_game_over")
	btn_sfx.play()
	pass # Replace with function body.
