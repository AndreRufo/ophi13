extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@export var BulletScene : PackedScene

@export var MaxHealth : int = 10;

var currentHealth : int = MaxHealth
var isStunned : bool = false;

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@export var MaxInvulnDuration : float = 0.5;
var invuln_timer : Timer;
var is_invuln : bool = false;

func _ready():
	var singletons = Singletons;
	singletons.PlayerCharacter = self;
	invuln_timer = Timer.new();
	invuln_timer.one_shot = true;
	invuln_timer.connect("timeout", on_invuln_timer_timeout);
	add_child(invuln_timer);

func on_invuln_timer_timeout():
	is_invuln = false;
	
func Stun(bumpDir):
	isStunned = true;
	velocity = bumpDir;
	%StunTimer.start();

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta


	if isStunned:
		move_and_slide()
		return;
	# Handle Jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_pressed("ui_accept"):
		var new_bullet = BulletScene.instantiate();
		new_bullet.position = $BulletOrigin.global_position;
		new_bullet.direction = transform.basis.z;
		get_node("../Bullets").add_child(new_bullet);
 
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		if !$Visual/Ophiucus_Anim2/AnimationPlayer.is_playing():
			$Visual/Ophiucus_Anim2/AnimationPlayer.play("Armature|mixamo_com|Layer0");
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		$Visual/Ophiucus_Anim2/AnimationPlayer.pause()
	
	var new_look_dir = position + direction
	
	if (direction.length() > 0):
		look_at(new_look_dir, Vector3.UP, true)

	move_and_slide()


func _on_stun_timer_timeout():
	isStunned = false;

func on_hurt_character(dmg : int):
	if(is_invuln):
		return;
	currentHealth -= 1;
	is_invuln = true;
	invuln_timer.start(MaxInvulnDuration);
	Singletons.player_damaged.emit(currentHealth);
