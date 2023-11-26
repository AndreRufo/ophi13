extends Node3D

@export var Signs : Array[PackedScene]
var currentSign = 0;

func _ready():
	var timer_label = Singletons.Hud.timer_label;
	timer_label.timer = $Timer;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	if currentSign >= 12:
		return;
		
	_spawn_new_enemy()

func _spawn_new_enemy():
	if !Singletons.PlayerCharacter:
		return;
		
	var new_sign : Node3D = Signs[currentSign].instantiate();
	var distVector = Vector3(20,0,20);
	var randomRotation = randf_range(0, 360);
	var rotatedVector = distVector.rotated(Vector3.UP, deg_to_rad(randomRotation));
	
	new_sign.position = Singletons.PlayerCharacter.position + Vector3(0, 0.5, 0) + rotatedVector;
	
	get_parent().add_child(new_sign);
	
	currentSign += 1;
	
	$Timer.start();
