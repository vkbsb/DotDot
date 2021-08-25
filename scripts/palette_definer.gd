extends Node

export(Array, PoolColorArray) var ColorPalettes = [
	[
		Color("FFC93C"),
		Color("DBF6E9"),
		Color("9DDFD3"),
		Color("31326F")
	],
	[
		Color("512D6D"),
		Color("00C1D4"),
		Color("EEEEEE"),
		Color("F8485E")
	],
	[
		Color("08D9D6"),
		Color("252A34"),
		Color("FF2E63"),
		Color("EAEAEA")
	],
	[
		Color("082032"),
		Color("2C394B"),
		Color("334756"),
		Color("FF4C29")
	],
	[
		Color("FFC93C"),
		Color("07689F"),
		Color("40A8C4"),
		Color("A2D5F2")
	],
	[
		Color("7579E7"),
		Color("9AB3F5"),
		Color("A3D8F4"),
		Color("B9FFFC")
	],
	[
		Color("DDDDDD"),
		Color("222831"),
		Color("30475E"),
		Color("F05454")
	],
]
var current
var registered_sprites = [
	[], 
	[],
	[],
	[]
]


func register_sprite(sprite_instance, color_index):
	registered_sprites[color_index].push_back(sprite_instance)

func change_palette(palette_index):
	assert(palette_index < ColorPalettes.size())
	current = ColorPalettes[palette_index]
	apply_current()

func apply_current():
	VisualServer.set_default_clear_color(current[0])
	for i in range(0, current.size()):
		var sprites = registered_sprites[i]
		for sprite in sprites:
			sprite.self_modulate = current[i]
			
func random_palette():
	change_palette(randi() % ColorPalettes.size())
	
func _ready():
	randomize()
	random_palette()

