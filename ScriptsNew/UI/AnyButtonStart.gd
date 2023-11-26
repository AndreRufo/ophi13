extends Label
@onready var TitleAnimationPlayer : AnimationPlayer = $"../TitleAnimationPlayer";
@export var main_world_scene : PackedScene;
var input_wait_timer : Timer;
var allow_input : bool = false;
var skipping : bool = false;
# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = create_tween();
	tween.set_loops();
	tween.set_trans(Tween.TRANS_LINEAR);
	tween.tween_property(self, "modulate:a", 1, 1);
	tween.tween_property(self, "modulate:a", 0, 1);
	input_wait_timer = Timer.new();
	input_wait_timer.one_shot = true;
	input_wait_timer.connect("timeout", on_input_wait_timer_timeout);
	add_child(input_wait_timer);
	
	input_wait_timer.start(8);
	
func on_input_wait_timer_timeout():
	allow_input = true;
	skipping = false;
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_anything_pressed():
		if(allow_input):
			get_tree().change_scene_to_packed(main_world_scene);
		elif(!allow_input && !skipping):
			input_wait_timer.stop();
			input_wait_timer.start(2);
			skipping = true;
			TitleAnimationPlayer.seek(12);
