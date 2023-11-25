extends CharacterBody3D

class_name BaseEnemy

@export var Speed : float = 1
@export var MaxHealth : int = 10 
var currentHealth : int = MaxHealth

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var player 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _update(delta):
	pass

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	player = Singletons.PlayerCharacter
	if not player:
		return
	_update(delta)
	
	move_and_slide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_damage_area_body_entered(body):
	if body.is_in_group("Character"):
		var player : CharacterBody3D = body;
		player.Stun((player.position - position)*10);
		player.currentHealth -= 1;
		Singletons.player_damaged.emit(player.currentHealth);
		if (player.currentHealth <= 0):
			player.queue_free();
	pass # Replace with function body.


func _on_bullet_capture_area_area_entered(area):
	if area.is_in_group("Bullet") && area.get_parent().is_player_bullet:
		area.get_parent().enemy = self
	pass # Replace with function body.


func _on_bullet_capture_area_area_exited(area):
	if area.is_in_group("Bullet") && area.get_parent().is_player_bullet:
		area.get_parent().enemy = null
	pass # Replace with function body.
