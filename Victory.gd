extends Node3D

@export var main_menu_scene : PackedScene;
@export var main_world_scene : PackedScene;

var input_wait_timer = Timer.new();
var allow_input : bool = false;

func _ready():
	$AnimationPlayer.play("loop");
	$SexyDance/AnimationPlayer.play("Armature|mixamo_com|Layer0_001");
	input_wait_timer.one_shot = true;
	input_wait_timer.connect("timeout", on_input_wait_timer_timeout);
	add_child(input_wait_timer);
	input_wait_timer.start(4);

func on_input_wait_timer_timeout():
	print("Ended timeout");
	allow_input = true;
	$Control.visible = true;

func _unhandled_input(event):
	if not event.is_released():
		if allow_input:
			if event.is_action_pressed("ui_accept"):
				get_tree().change_scene_to_packed(main_world_scene);
			elif event.is_action_pressed("ui_cancel"):
				get_tree().change_scene_to_packed(main_menu_scene);
		elif not allow_input:
			input_wait_timer.stop();
			on_input_wait_timer_timeout();
