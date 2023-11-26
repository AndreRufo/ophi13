extends Label

@export var main_world_scene : PackedScene;

# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = create_tween();
	tween.set_loops();
	tween.set_trans(Tween.TRANS_LINEAR);
	tween.tween_property(self, "modulate:a", 1, 1);
	tween.tween_property(self, "modulate:a", 0, 1);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_anything_pressed():
		get_tree().change_scene_to_packed(main_world_scene);
