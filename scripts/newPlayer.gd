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

	circle_radius = $Ring/Circle1/Sprite2.get_rect().size.x / 2 * $Ring/Circle1/Sprite2.scale.x
	
	switchCircle()
	pass # Replace with function body.

func _process(delta):
	rotation += delta*direction*rot_speed

func get_next_pos():
	return targets[target_index].global_position
	
func get_ring_radius():
	return $Ring.get_rect().size.x/2

func switchCircle():
	var offset = direction * 130
	targets[target_index].position = Vector2(0, 2*offset)
	targets[(target_index+1)%2].position = Vector2(0, 0)
	$Ring.offset.y = offset
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		direction *= -1
		position = targets[target_index].global_position
		target_index += 1
		target_index %= 2
		switchCircle()
		
	if event.is_action_pressed("ui_right"):
		print("Rotation", rotation)
		rotation += 0.05
#		print("Pffset:", offset)
		
