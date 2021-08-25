extends "res://scripts/state_machine/state_machine.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var pausemenu = $Pause
onready var mainmenu = $MainMenu
onready var gameover = $GameOver
onready var gameplay = $GamePlay

# Called when the node enters the scene tree for the first time.
func _ready():
	states_map = {
		"MainMenu": mainmenu,
		"Pause": pausemenu,
		"GameOver": gameover,
		"GamePlay": gameplay
	}
	start_state = "MainMenu"

func _change_state(state_name):
	._change_state(state_name)
