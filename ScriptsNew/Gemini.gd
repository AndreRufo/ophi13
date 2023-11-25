extends BaseEnemy

@export var AngleCurve : Curve;
var firstHits : int = 3

var currentCurveVal = 0;

func _ready():
	Speed = 0.1
	
	var spawners = $BulletSpawnersContainer.get_children();
	for spawner in spawners:
		spawner.SetSpawnInterval(0.1);

func _update(delta):
	var rotAngle = AngleCurve.sample(currentCurveVal);
	$BulletSpawnersContainer.rotate_y(deg_to_rad(rotAngle));
	currentCurveVal += delta * 0.1;
	
	var direction : Vector3 = (player.position - position)
	var new_velocity = (player.position - position) * Speed
	velocity.x = new_velocity.x
	velocity.z = new_velocity.z
	pass

func _split():
	var new_sign : Node3D = self.duplicate();
	new_sign.firstHits = 10
