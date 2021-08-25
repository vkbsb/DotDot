extends "res://scripts/state_machine/state.gd"

export(NodePath) var main_menu_path
onready var animation_player = $"../../AnimationPlayer"

export(NodePath) var btn_sfx_path
onready var btn_sfx = get_node(btn_sfx_path)

var main_menu
# Called when the node enters the scene tree for the first time.
func _ready():
	main_menu = get_node(main_menu_path)
	pass # Replace with function body.


func enter():
	main_menu.visible = true
	animation_player.play("show_main_menu")
	pass

# Clean up the state. Reinitialize values like a timer.
func exit():
	main_menu.visible = false
	pass


func handle_input(_event):
	pass


func update(_delta):
	pass


func _on_animation_finished(_anim_name):
#	print("AnimationFinished", _anim_name, animation_player.get_playing_speed(), animation_player.playback_speed)
	if _anim_name == "hide_main_menu" and animation_player.get_playing_speed() < 1:
		main_menu.visible = false
		emit_signal("finished", "GamePlay")
	


func _on_PlayButton_pressed():
	animation_player.play_backwards("show_main_menu")
	btn_sfx.play()
	pass # Replace with function body.
