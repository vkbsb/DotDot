extends Sprite

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func remove_from_parent():
	print("removing")
	self.get_parent().remove_child(self)

func _exit_tree():
	self.queue_free()

func play_appear():
	$AnimationPlayer.play("appear")

func play_hide():
	$AnimationPlayer.play("hide")
