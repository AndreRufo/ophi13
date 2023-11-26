class_name BulletSpawner
extends Node3D

@export var BulletScene : PackedScene
@export var BulletMaterial : StandardMaterial3D
@export var AngleDeviation : float = 5

@export var disableShooting : bool = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	$BulletSpawnInterval.start();
	
func SetSpawnInterval(interval):
	$BulletSpawnInterval.wait_time = interval;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func ShootBullet(direction):
	var new_bullet : Node3D = BulletScene.instantiate();
	new_bullet.position = global_position;
	new_bullet.direction = direction;
	new_bullet.is_player_bullet = false;
	new_bullet.SetColor(BulletMaterial);
	
	get_node("../../../Bullets").add_child(new_bullet);
	
	if Singletons.audioSourcesPlaying < Singletons.MAX_AUDIO_SOURCES :
		# Get play sound chance
		var rng = RandomNumberGenerator.new()
		var my_random_number = rng.randi_range(0, 1)
		if(my_random_number == 1) :
			$AudioStreamPlayer.play()
			Singletons.audioSourcesPlaying += 1


func _on_bullet_spawn_interval_timeout():
	if disableShooting:
		$BulletSpawnInterval.start();
		return;
	var angle = randf_range(-AngleDeviation, AngleDeviation);
	var shootDir = global_transform.basis.z;
	var rotatedDir = shootDir.rotated(Vector3.UP, deg_to_rad(angle))
	ShootBullet(rotatedDir);
	$BulletSpawnInterval.start();
	pass # Replace with function body.


func _on_audio_stream_player_finished():
	Singletons.audioSourcesPlaying -= 1


func _on_audio_stream_player_tree_exiting():
	Singletons.audioSourcesPlaying -= 1
