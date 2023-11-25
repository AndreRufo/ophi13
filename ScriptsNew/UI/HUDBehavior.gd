extends CanvasLayer

@onready var bullseye_scene = load("res://Prefabs/UI/hud_bullseye.tscn");

func _ready():
	var singletons = Singletons;
	singletons.Hud = self;

func spawn_bullseye():
	var bullseye_inst = bullseye_scene.instantiate();
	add_child(bullseye_inst);
	return bullseye_inst;
