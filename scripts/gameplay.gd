extends Node2D

onready var player = $Player
var target 
var outObj
var dir = 1;
var rotSpeed = 2
var score = 0
var scoreLabel
#onready var crosshair = preload("res://scenes/crosshair.scn")
var chInstance
var bestScore


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
