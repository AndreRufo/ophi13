extends BaseEnemy

@export var AngleCurve : Curve;
@export var ChargeSpeed : float = 8
#@export var TriggerChargeDistance : float = 5
var Charging : bool = false
var charge_velocity : Vector3
var charge_timer = 0
var randomDir : float = 0

var currentCurveVal = 0;

func _ready():
	ChargeSpeed = 8
	
	Speed = 0.2
	
	var spawners = $BulletSpawnersContainer.get_children();
	for spawner in spawners:
		spawner.SetSpawnInterval(0.6);

func _update(delta):
	if Charging :
		var rotAngle = AngleCurve.sample(currentCurveVal);
		$BulletSpawnersContainer.rotate_y(deg_to_rad(rotAngle * randomDir));
		
		var normalized_dir = (player.position - position).normalized()
		self.rotate_y(deg_to_rad(randomDir))
		charge_velocity = normalized_dir * ChargeSpeed
		var random_dir_vector : Vector3 = Vector3(0, randomDir, 0)
		charge_velocity = charge_velocity * random_dir_vector
		var new_look_dir = position + charge_velocity
	
		if (charge_velocity.length() > 0):
			look_at(new_look_dir, Vector3.UP, true)
		
		currentCurveVal += delta * 0.1;
		_charge(delta)
	else :
		var rotAngle = AngleCurve.sample(currentCurveVal);
		$BulletSpawnersContainer.rotate_y(deg_to_rad(rotAngle));
		currentCurveVal += delta * 0.1;
		
		var direction : Vector3 = (player.position - position)
		var new_velocity = (player.position - position) * Speed
		velocity.x = new_velocity.x
		velocity.z = new_velocity.z
		charge_timer+=1
		if charge_timer > 80 :
			Charging = true
			var spawners = $BulletSpawnersContainer.get_children();
			for spawner in spawners:
				spawner.SetSpawnInterval(0.01);
			charge_timer = 0
			var rng = RandomNumberGenerator.new()
			randomDir = rng.randi_range(-1, 1)
			if randomDir == -1 :
				randomDir = -45
			else :
				randomDir = 45
	pass

func _charge(delta):
	charge_timer+=1
	if charge_timer > 120 :
		Charging = false
		
		var spawners = $BulletSpawnersContainer.get_children();
		for spawner in spawners:
			spawner.SetSpawnInterval(0.6);
		charge_timer = 0
	else:
		velocity.x = charge_velocity.x
		velocity.z = charge_velocity.z
