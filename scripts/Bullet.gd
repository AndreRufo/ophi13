extends Node3D

@export var direction : Vector3

@export var is_player_bullet : bool = true;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += direction * delta * 50;


func _on_timer_timeout():
	queue_free()


func _on_area_3d_body_entered(body):
	if is_player_bullet && body.is_in_group("Character"):
		return;
	queue_free()
