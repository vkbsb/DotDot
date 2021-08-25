extends Node2D

var targets
var target_index 
var direction = 1
var circle_radius = 0
export(int) var rot_speed = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	$Ring/Circle1.position = Vector2(0, -130)
	$Ring/Circle2.position = Vector2(0, 130)
	
	targets = Array()
	targets.push_back($Ring/Circle1)
	targets.push_back($Ring/Circle2)
	
	target_index = 1
	direction = 1
	
	circle_radius = $Ring/Circle1/Sprite.get_rect().size.x / 2 * $Ring/Circle1/Sprite.scale.x
	
	switchCircle()
	
	
	ColorPalette.register_sprite($Ring/Circle1/dot_indicator, 3)
	ColorPalette.register_sprite($Ring/Circle1/Sprite, 1)
	ColorPalette.register_sprite($Ring/Circle2/dot_indicator, 3)
	ColorPalette.register_sprite($Ring/Circle2/Sprite, 1)
	ColorPalette.apply_current()
	
	pass # Replace with function body.

func on_update(delta):
	rotation += delta*direction*rot_speed
	pass

func get_next_pos():
	return targets[(target_index+1)%2].global_position
	
func get_ring_radius():
	return $Ring.get_rect().size.x/2

func switchCircle():
	var offset = direction * 130
	targets[target_index].position = Vector2(0, 2*offset)
	targets[(target_index+1)%2].position = Vector2(0, 0)
	$Ring.offset.y = offset
	$AudioStreamPlayer2D.play()
	
func on_input(event):
	if event.is_action_pressed("ui_select"):
		direction *= -1
		position = targets[target_index].global_position
		target_index += 1
		target_index %= 2
		switchCircle()
		
#	if event.is_action_pressed("ui_right"):
#		print("Rotation", rotation)
#		rotation += 0.05
#		print("Pffset:", offset)
		
