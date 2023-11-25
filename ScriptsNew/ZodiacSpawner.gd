extends Node3D

@export var Signs : Array[PackedScene]
var currentSign = 0;

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	if currentSign >= 12:
		return;
		
	_spawn_new_enemy()

func _spawn_new_enemy():
	var new_sign : Node3D = Signs[currentSign].instantiate();
	new_sign.position = Singletons.PlayerCharacter.position + Vector3(20, 0.5, 20);
	
	get_parent().add_child(new_sign);
	
	currentSign += 1;
	
	$Timer.start();
