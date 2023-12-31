extends CharacterBody3D

class_name BaseEnemy

@export var Speed : float = 1
@export var MaxHealth : int = 10 
@export var BulletDamage : int = 1;
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
	if not is_on_floor() && position.y > 1.5:
		velocity.y -= gravity * delta
	
	if position.y <= 1.5 :
		velocity.y = 0
	
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
		player.on_hurt_character(BulletDamage);
		if (player.currentHealth <= 0):
			player.Kill();
	pass # Replace with function body.


func _on_bullet_capture_area_area_entered(area):
	if area.is_in_group("Bullet") && area.get_parent().is_player_bullet:
		area.get_parent().enemy = self
	pass # Replace with function body.


func _on_bullet_capture_area_area_exited(area):
	if area.is_in_group("Bullet") && area.get_parent().is_player_bullet:
		area.get_parent().enemy = null
	pass # Replace with function body.

func on_take_damage():
	$AnimationPlayer.stop();
	$AnimationPlayer.play("Hit")
	$AudioStreamPlayer3D.stop()
	$AudioStreamPlayer3D.play()
	pass;
	
func on_death():
	Singletons.NumEnemiesDefeated += 1;
