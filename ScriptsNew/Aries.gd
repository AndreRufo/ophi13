extends BaseEnemy

func _update(delta):
	var new_velocity = player.position - position
	velocity.x = new_velocity.x
	velocity.z = new_velocity.z

	$BulletSpawnersContainer.rotate_y(deg_to_rad(0.5));
