
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"
var player
var target
var outObj
var dir = 1;
var rotSpeed = 2
var score = 0
var scoreLabel
var crosshair
var chInstance
var bestScore

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	crosshair = load("res://scenes/crosshair.scn")
	chInstance = null
	
	player = get_node("player")
	set_process_input(true)
	set_fixed_process(true)
	
	outObj = get_node("FadingObject")
	scoreLabel = get_node("ui/score")
	
	#create the targets' array
	target = Array()
	target.push_back(get_node("target1"))
	target.push_back(get_node("target2"))
	
	placeNextTarget()
	
	get_tree().set_pause(true)
	
	#load the best score from file.
	bestScore = self.get_option("score", "best", 0)
	pass

func placeNextTarget():
	var targetIndex = player.get_target_index()
	var radius = player.get_ring_radius() * player.get_scale().x
	var angle = rand_range(-3.14/2, 3.14/2)
	var pos = Vector2(radius * cos(angle), radius * sin(angle))
	target[targetIndex].set_pos(pos + player.get_pos())
	target[targetIndex].get_node("AnimationPlayer").play("fadein")
	pass
	
func _fixed_process(delta):
	player.set_rot(player.get_rot() + delta * rotSpeed * dir)
	
func _input(event):
	if event.is_action_pressed("mouse_left"):
		var npos = player.get_next_pos()
		var cr = player.get_circle_radius() * player.get_scale().x
		var t = target[player.get_target_index()]
		var tpos = t.get_pos()
		var tr = t.get_item_rect().size.width / 2 * t.get_scale().x
		
		if npos.distance_to(tpos) > tr + cr:
			#circles do not overlap. GameOver
			get_node("ui/GameOver").show()
			get_node("ui/GameOver/Button/AnimationPlayer").play("buttonAppear")
			if bestScore < score:
				set_option("score", "best", score)
				bestScore = score
			get_node("ui/GameOver/best").set_text("Best: " + str(bestScore))
			get_tree().set_pause(true)
			pass
		else: #circles overlap
			get_node("target1/Label").hide()
			if chInstance:
				chInstance.get_node("AnimationPlayer").play("hide")
				chInstance = null
				
			#show the fake target fading out.
			var indx = (player.get_target_index() + 1) % 2
			outObj.set_pos(target[indx].get_pos())
			outObj.show()
			outObj.get_node("AnimationPlayer").play("fadeout")
			
			#set the player position
			player.set_pos(npos)
			player.change_center()
			placeNextTarget()

			#change the direction of rotation.
			dir *= -1
			if tr-cr > npos.distance_to(tpos):
				#circle was inside. play +1 animation
				self.score += 1
				var node = crosshair.instance()
				var indx = (player.get_target_index() + 1) % 2
				node.set_pos(target[indx].get_pos())
				add_child(node)
				chInstance = node
				
			self.score += 1
			self.scoreLabel.set_text(str(self.score))
			
			if self.score >= 3:
				self.rotSpeed = 3
			if self.score >= 10:
				self.rotSpeed = 4
				
func play_clicked():
	get_tree().set_pause(false)
	get_node("ui/MainMenu").hide()

func play_again_clicked():
	get_tree().reload_current_scene()
	
func get_option(section, key, default):
    var config = ConfigFile.new()
    config.load("user://config.ini")
    var value = config.get_value(section, key, default)
    return value

func set_option(section, key, value):
    var config = ConfigFile.new()
    config.load("user://config.ini")
    config.set_value(section, key, value)
    config.save("user://config.ini")