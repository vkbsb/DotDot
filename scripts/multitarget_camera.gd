extends Camera2D

export var move_speed = 0.5  # camera position lerp speed

export var zoom_speed = 0.25  # camera zoom lerp speed

export var min_zoom = 1.5  # camera won't zoom closer than this

export var max_zoom = 5  # camera won't zoom farther than this

export var margin = Vector2(400, 200)  # include some buffer area around targets


var targets = []  # Array of targets to be tracked.


onready var screen_size = get_viewport_rect().size

func _process(delta):
	if !targets:
		return
	# Keep the camera centered between the targets

	var p = Vector2.ZERO
	for target in targets:
		p += target.position
	p /= targets.size()
	position = lerp(position, p, move_speed)
	# Find the zoom that will contain all targets

	var r = Rect2(position, Vector2.ONE)
	for target in targets:
		r = r.expand(target.position)
	r = r.grow_individual(margin.x, margin.y, margin.x, margin.y)
	var d = max(r.size.x, r.size.y)
	var z
	if r.size.x > r.size.y * screen_size.aspect():
		z = clamp(r.size.x / screen_size.x, min_zoom, max_zoom)
	else:
		z = clamp(r.size.y / screen_size.y, min_zoom, max_zoom)
	zoom = lerp(zoom, Vector2.ONE * z, zoom_speed)

func add_target(t):
	if not t in targets:
		targets.append(t)

func remove_target(t):
	var indx = targets.find(t)
	if indx > -1:
		targets.remove(indx)
	#if t in targets:
	#	targets.remove(t)
