extends Node2D

var CROSS_HAIR = preload("res://scenes/crosshair.scn")
onready var fading_object = $FadingObject
onready var target_1 = $Target1
onready var target_2 = $Target2
onready var player = $Player
var MAX_ROT_SPEED = 4
var targets = []
var target_index = 1
var cross_hair = null
var indx = 0

signal target_status(status)

# Called when the node enters the scene tree for the first time.
func _ready():
	targets.push_back(target_1)
	targets.push_back(target_2)
	targets[player.target_index].position = player.position
#	cross_hair = CROSS_HAIR.instance()
#	cross_hair.visible = false
#	add_child(cross_hair)

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
func game_process(delta):
	player.on_update(delta)
	
func _unhandled_input(event):
	if event.is_action_pressed("ui_select"):
		cross_hair = CROSS_HAIR.instance()
		add_child(cross_hair)
		cross_hair.visible = true
		cross_hair.position = targets[target_index].position
		var input_status = cross_hair.STATUS.WRONG
		
		var distance = player.get_next_pos().distance_to(targets[target_index].position)
		if distance < 10.0: #TODO: pick this value from the radius of collider on player dots.
#				print("Perfect")
			input_status = cross_hair.STATUS.RIGHT
			player.rot_speed += 0.2
			pass
		elif distance < 52:
#				print("Close")
			input_status = cross_hair.STATUS.WARNING
			player.rot_speed += 0.1
			pass
		else :
			print("Failed", distance)
			input_status = cross_hair.STATUS.WRONG
			
		if player.rot_speed >= MAX_ROT_SPEED:
			player.rot_speed = MAX_ROT_SPEED

		cross_hair.play_appear(input_status)
		emit_signal("target_status", input_status)
		targets[(target_index+1)%2].get_node("AnimationPlayer").play("fadeout")
		place_next_target()

