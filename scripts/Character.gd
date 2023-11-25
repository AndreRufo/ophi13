extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@export var BulletScene : PackedScene

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _onready():
	var singletons = Singletons;
	singletons.PlayerCharacter = self;

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_pressed("ui_accept"):
		var new_bullet = BulletScene.instantiate();
		new_bullet.position = position + transform.basis.z + Vector3(0, 0.5, 0);
		new_bullet.direction = transform.basis.z;
		%Bullets.add_child(new_bullet);

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	var new_look_dir = position + direction
	
	look_at(lerp(position + transform.basis.z, new_look_dir, 0.5), Vector3.UP, true)

	move_and_slide()
