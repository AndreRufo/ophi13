extends BaseEnemy

func _update(delta):
	var new_velocity = player.position - position
	velocity.x = new_velocity.x
	velocity.z = new_velocity.z

