extends Node3D

@export var direction : Vector3
@export var speed : float = 50;

@export var is_player_bullet : bool = true;

var enemy : CharacterBody3D = null;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func SetColor(color : StandardMaterial3D):
	$Visual.material_override = color;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var newDir = direction;
	
	if is_player_bullet:
		if enemy:
			var diffToTarget = (enemy.position - position).normalized();
			var lerpFactor = $Timer.time_left / $Timer.wait_time;
			newDir = lerp(direction, diffToTarget, lerpFactor*0.3);
		
	position += newDir * delta * speed;


func _on_timer_timeout():
	queue_free()


func _on_area_3d_body_entered(body):
	if is_player_bullet && body.is_in_group("Character"):
		return;
		
	if !is_player_bullet && body.is_in_group("Enemy"):
		return;
		
	if is_player_bullet && body.is_in_group("Enemy"):
		body.currentHealth -= 1;
		if (body.currentHealth <= 0):
			body.queue_free();
		
	if !is_player_bullet && body.is_in_group("Character"):
		body.currentHealth -= 1;
		Singletons.player_damaged.emit(body.currentHealth);
		if (body.currentHealth <= 0):
			body.queue_free();
		
	queue_free()
