extends CharacterBody3D

class_name Enemy

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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
