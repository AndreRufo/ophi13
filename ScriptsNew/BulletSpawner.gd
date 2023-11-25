class_name BulletSpawner
extends Node3D

@export var BulletScene : PackedScene
@export var BulletMaterial : StandardMaterial3D
@export var AngleDeviation : float = 5

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
	new_bullet.position = get_parent().get_parent().position + Vector3(0, 0.5, 0);
	new_bullet.direction = direction;
	new_bullet.is_player_bullet = false;
	new_bullet.SetColor(BulletMaterial);
	
	get_node("../../../Bullets").add_child(new_bullet);


func _on_bullet_spawn_interval_timeout():
	var angle = randf_range(-AngleDeviation, AngleDeviation);
	var shootDir = global_transform.basis.z;
	var rotatedDir = shootDir.rotated(Vector3.UP, deg_to_rad(angle))
	ShootBullet(rotatedDir);
	$BulletSpawnInterval.start();
	pass # Replace with function body.
