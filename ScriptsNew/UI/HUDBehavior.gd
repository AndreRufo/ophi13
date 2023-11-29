extends CanvasLayer

@export var timer_label : Label;
@export var pause_menu : CenterContainer;
@export var continue_btn : Button;
@export var menu_btn : Button;
@export var exit_btn : Button;
@export var loss_screen : CenterContainer;
@export var main_menu_scene = "res://Prefabs/UI/MainMenu.tscn";

@onready var bullseye_scene = load("res://Prefabs/UI/hud_bullseye.tscn");

func _ready():
	var singletons = Singletons;
	singletons.Hud = self;
	var continue_fn = func():
		get_tree().paused = false;
		pause_menu.visible = false;
	continue_btn.button_down.connect(continue_fn);
	var menu_fn = func():
		get_tree().change_scene_to_file(main_menu_scene);
		Singletons.NumEnemiesDefeated = 0;
		get_tree().paused = false;
	menu_btn.button_down.connect(menu_fn);
	var exit_fn = func():
		get_tree().quit();
	exit_btn.button_down.connect(exit_fn);
	singletons.player_damaged.connect(func(current_health):
		if current_health <= 0:
			loss_screen.visible = true;
	);

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel") and Singletons.PlayerCharacter.currentHealth > 0:
		get_tree().paused = true;
		pause_menu.visible = true;
	if Singletons.PlayerCharacter.currentHealth <= 0:
		if Input.is_action_just_pressed("ui_accept"):
			get_tree().reload_current_scene();
		elif Input.is_action_just_pressed("ui_cancel"):
			get_tree().change_scene_to_file(main_menu_scene);
			Singletons.NumEnemiesDefeated = 0;
			get_tree().paused = false;

func spawn_bullseye():
	var bullseye_inst = bullseye_scene.instantiate();
	add_child(bullseye_inst);
	return bullseye_inst;
