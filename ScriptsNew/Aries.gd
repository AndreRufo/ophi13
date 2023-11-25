extends BaseEnemy

@export var ChargeSpeed : float = 1
@export var TriggerChargeDistance : float = 1
var Charging : bool = false
var charge_velocity : Vector3
var charge_timer = 0

func _update(delta):
	$BulletSpawnersContainer.rotate_y(deg_to_rad(0.5));
	if Charging :
		_charge(delta)
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

func _charge(delta):
	charge_timer+=1
	if charge_timer > 100 :
		Charging = false
		charge_timer = 0
	else:
		velocity.x = charge_velocity.x
		velocity.z = charge_velocity.z
