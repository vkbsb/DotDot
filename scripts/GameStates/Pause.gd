extends "res://scripts/state_machine/state.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(NodePath) var hud_path
onready var hud = get_node(hud_path)
var tween
# Called when the node enters the scene tree for the first time.
func _ready():
#	tween = Tween.new()
#	add_child(tween)
	pass # Replace with function body.


func enter():
	hud.get_node("ColorRect").visible = true
	hud.mouse_filter = Control.MOUSE_FILTER_STOP
	pass

# Clean up the state. Reinitialize values like a timer.
func exit():
	hud.get_node("ColorRect").visible = false
	hud.mouse_filter = Control.MOUSE_FILTER_IGNORE
	pass


func handle_input(_event):
	pass


func update(_delta):
	pass


func _on_animation_finished(_anim_name):
	pass


func _on_PauseButton_toggled(button_pressed):
	if button_pressed == false:
		emit_signal("finished", "GamePlay")
	pass # Replace with function body.
