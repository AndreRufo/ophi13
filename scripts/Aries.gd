extends Enemy

func _update(delta):
	var new_velocity = position - player.position
	velocity.x = new_velocity.x
	velocity.z = new_velocity.z

