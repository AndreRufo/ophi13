extends BaseEnemy

@export var ChargeSpeed : float = 10
@export var TriggerChargeDistance : float = 5
var Charging : bool = false
var charge_velocity : Vector3
var charge_timer = 0

@export var AngleCurve : Curve;

var currentCurveVal = 0;

func _ready():
	self.Speed = 0.2
	pass # Replace with function body.

func _update(delta):
	if Charging :
		_charge(delta)
		var rotAngle = AngleCurve.sample(currentCurveVal);
		$BulletSpawnersContainer.rotate_y(deg_to_rad(rotAngle));
	
		var new_look_dir = position + charge_velocity
	
		if (charge_velocity.length() > 0):
			look_at(new_look_dir, Vector3.UP, true)
		
		currentCurveVal += delta * 0.1;
	else :
		var direction : Vector3 = (player.position - position)
		var length : float = direction.length()
		if length < TriggerChargeDistance :
			print("charging")
			Charging = true
			var normalized_dir = direction.normalized()
			charge_velocity = normalized_dir * ChargeSpeed
		else :
			var new_velocity = (player.position - position) * Speed
			velocity.x = new_velocity.x
			velocity.z = new_velocity.z
			
		var rotAngle = AngleCurve.sample(currentCurveVal);
		$BulletSpawnersContainer.rotate_y(deg_to_rad(rotAngle));
	
		var new_look_dir = position + direction
	
		if (direction.length() > 0):
			look_at(new_look_dir, Vector3.UP, true)
		currentCurveVal += delta * 0.1;

func _charge(delta):
	charge_timer+=1
	if charge_timer > 100 :
		Charging = false
		charge_timer = 0
	else:
		velocity.x = charge_velocity.x
		velocity.z = charge_velocity.z
