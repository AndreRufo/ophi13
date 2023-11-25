extends BaseEnemy

@export var AngleCurve : Curve;

var currentCurveVal = 0;

func _ready():
	Speed = 0.15
	
	var spawners = $BulletSpawnersContainer.get_children();
	for spawner in spawners:
		spawner.SetSpawnInterval(2.5);

func _update(delta):
	# var rotAngle = AngleCurve.sample(currentCurveVal);
	# $BulletSpawnersContainer.rotate_y(deg_to_rad(rotAngle));
	
	var direction : Vector3 = (player.position - position)
	var new_velocity = (player.position - position) * Speed
	velocity.x = new_velocity.x
	velocity.z = new_velocity.z
	var new_look_dir = position + new_velocity
	look_at(lerp(global_transform.basis.z, new_look_dir, 1), Vector3.UP, true)
	pass
