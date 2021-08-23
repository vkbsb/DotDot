extends Node2D

var CROSS_HAIR = preload("res://scenes/crosshair.scn")
onready var fading_object = $FadingObject
onready var target_1 = $Target1
onready var target_2 = $Target2
onready var player = $Player
var targets = []
var target_index = 1
var cross_hair = null

# Called when the node enters the scene tree for the first time.
func _ready():
	targets.push_back(target_1)
	targets.push_back(target_2)
	targets[player.target_index].position = player.position
	cross_hair = CROSS_HAIR.instance()
	add_child(cross_hair)
	
	place_next_target()
	
	$Camera2D.add_target(player)
	pass # Replace with function body.

func place_next_target():
	randomize()
	var radius = 2*player.get_ring_radius()	
	target_index = (player.target_index+1)%2
	
	$Camera2D.remove_target(targets[player.target_index])
	$Camera2D.add_target(targets[target_index])
	
	var next_target = targets[target_index]
	var theta = 	rand_range(-3.14/2, 3.14/2) #randf() * 2 * PI
	#print(theta, cos(theta))
	next_target.position = player.position +  Vector2(radius * cos(theta), radius * sin(theta))
	next_target.get_node("AnimationPlayer").play("fadein")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event.is_action_pressed("ui_accept"):
		var olb = targets[target_index].get_node("Area2D").get_overlapping_bodies()
		if olb.size() > 0:
			var distance = olb[0].global_position.distance_to(targets[target_index].position)			
			cross_hair.position = targets[target_index].position
			cross_hair.play_appear()
			if distance < 1.0:
#				print("Perfect")
				pass
			else:
#				print("Close")
				pass
			targets[(target_index+1)%2].get_node("AnimationPlayer").play("fadeout")
			place_next_target()
		else:
			print("Failed")
