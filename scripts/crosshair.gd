extends Sprite
export(Array, Texture) var status_textures
enum STATUS {
	RIGHT = 0,
	WARNING = 1,
	WRONG = 2
}
var cur_status = STATUS.RIGHT

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	$Success.emitting = false
	pass

func remove_from_parent():
	self.get_parent().remove_child(self)

func _exit_tree():
	self.queue_free()

func play_appear(status):
	$Success.emitting = false
	$Success.visible = false
	$AnimationPlayer.stop()
	$Status.texture = status_textures[status]
	cur_status = status
	$AnimationPlayer.play("appear")

func play_hide():
	$AnimationPlayer.play("hide")

func reset_particles():
	if cur_status == STATUS.RIGHT:
		$Success.emitting = true
		$Success.visible = true
		$Success.restart()
		$right_indicator.self_modulate = ColorPalette.current[3]#Color.greenyellow
		$Success2.play()
	elif cur_status == STATUS.WARNING:
		$right_indicator.self_modulate = ColorPalette.current[2]#Color.yellow
		$Miss.play()
	elif cur_status == STATUS.WRONG:
		$Failed.play()
		$right_indicator.self_modulate = ColorPalette.current[1] #Color.red
