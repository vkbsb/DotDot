
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"
var ring
var targetIndex
var circleRadius

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	ring = get_node("ring")
	targetIndex = 0;
	var circle = ring.get_node("circle1")
	circleRadius = circle.get_rect().size.x/2 * circle.scale.x #circle.get_item_rect().size.width/2 * circle.get_scale().x
	pass

func get_circle_radius():
	return circleRadius
	
func get_ring_radius():
	return ring.get_rect().size.x

func get_target_index():
	return targetIndex;
	
func get_next_pos():
	if(ring.position.y < 0):
		return ring.get_node("circle1").global_position
	else:
		return ring.get_node("circle2").global_position
		
func change_center():
	if(ring.get_pos().y < 0):
		ring.set_pos(Vector2(0, 130))
		targetIndex = 1
	else:
		ring.set_pos(Vector2(0, -130))
		targetIndex = 0
		
