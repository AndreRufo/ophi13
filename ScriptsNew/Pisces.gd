extends BaseEnemy

@export var AngleCurve : Curve;

var currentCurveVal = 0;

func _ready():
	Speed = 0.2
	
	var spawners = $BulletSpawnersContainer.get_children();
	for spawner in spawners:
		spawner.SetSpawnInterval(0.5);

func _update(delta):
	var rotAngle = AngleCurve.sample(currentCurveVal);
	$BulletSpawnersContainer.rotate_y(deg_to_rad(rotAngle));
	currentCurveVal += delta * 0.1;
	
	var direction : Vector3 = (player.position - position)
	var new_velocity = (player.position - position) * Speed
	velocity.x = new_velocity.x
	velocity.z = new_velocity.z
	pass
