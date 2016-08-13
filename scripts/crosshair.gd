
extends Sprite

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func remove_from_parent():
	print("removing")
	self.get_parent().remove_child(self)

func _exit_tree():
	self.queue_free()

