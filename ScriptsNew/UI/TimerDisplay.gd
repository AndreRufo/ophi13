extends Label

var timer : Timer = null;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var seconds = timer.time_left
	text = "%02d" % [seconds]
