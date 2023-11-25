extends Label

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var minutes = $"../Timer".time_left / 60
	var seconds = fmod(60, $"../Timer".time_left)
	text = "%02d:%02d" % [minutes, seconds]
