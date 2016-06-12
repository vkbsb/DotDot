
extends CanvasLayer

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	get_node("MainMenu/Button").connect("pressed", get_node(".."), "play_clicked")
	get_node("GameOver/Button").connect("pressed", get_node(".."), "play_again_clicked")
	pass
