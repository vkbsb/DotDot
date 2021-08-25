extends Node2D

var player_inside = false

func _ready():
	ColorPalette.register_sprite($target_indicator, 3)
	ColorPalette.register_sprite($target_ring, 2)
	ColorPalette.apply_current()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(_body):
	player_inside = true
	pass # Replace with function body.


func _on_Area2D_body_exited(_body):
	player_inside = false
	pass # Replace with function body.
