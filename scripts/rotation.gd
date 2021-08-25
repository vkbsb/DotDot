
extends Node2D

onready var ring = self
onready var c1 = $circle1
onready var c2  = $circle2
var t1
var t2

export var offset = 130

func setupRotOnCircle2():
	ring.set_offset(Vector2(0, -offset))
	
	c2.position = Vector2(0, 0)
	c1.position = Vector2(0, -2*offset)
	
func setupRotOnCircle1():
	ring.set_offset(Vector2(0, offset))
	c1.position = Vector2(0, 0)
	c2.position = Vector2(0, 2*offset)
	
	
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
#	set_fixed_process(true)
#	ring = get_node("ring")
#	c1 = get_node("ring/circle1")
#	c2 = get_node("ring/circle2")
#	t1 = get_node("target1")
#	t2 = get_node("target2")
	setupRotOnCircle2()
	pass

func _process(delta):
	ring.rotation = ring.rotation + 1*delta


