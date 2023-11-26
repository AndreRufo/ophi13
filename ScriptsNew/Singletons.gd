extends Node

const GENISYS_URL = "localhost";
const GENISYS_PORT = 3333;

var PlayerCharacter : CharacterBody3D;
var CameraObject : Camera3D;
var Hud : CanvasLayer;
var NumEnemiesDefeated = 0;
var genisys_client = WebSocketClient.new();

signal player_damaged(hp_after_dmg);

# Called when the node enters the scene tree for the first time.
func _ready():
	var genisys_full_url = "ws://%s:%d" % [GENISYS_URL, GENISYS_PORT];
	if (genisys_client.connect_to_url("ws://%s:%d" % [GENISYS_URL, GENISYS_PORT]) != OK):
		print("Could not connect to a genisys client at: ", genisys_client);
	else:
		genisys_client.message_received.connect(_process_genisys_message)
		print("Connected to " + genisys_full_url);
	pass

func get_action_from_key(genisys_key):
	if genisys_key == "play":
		return "ui_accept"
	if genisys_key == "play_18":
		return "ui_left"
	if genisys_key == "play_38":
		return "ui_down"
	if genisys_key == "bet_3":
		return "ui_up"
	if genisys_key == "play_68":
		return "ui_right"
	if genisys_key == "bet_1":
		return "ui_cancel"
	return null

func _process_genisys_message(message):
	var json = JSON.new();
	var parsed = json.parse_string(message);

	if not parsed:
		print("Failed to parse message")
		return

	if parsed.id != "service::hardware/inputs/status_change":
		return

	var key = parsed.payload.data.name
	var state = parsed.payload.data.input_state == "active"
	var action = get_action_from_key(key)
	if action:
		var event = InputEventAction.new()
		event.action = action
		event.pressed = state
		Input.parse_input_event(event)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if genisys_client:
		genisys_client._process(delta)
