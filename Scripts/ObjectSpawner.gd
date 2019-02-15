extends Path2D
export var object_instance = preload("res://Scenes/Mobs/RigidEnemy.tscn")
export var enabled = true
onready var spawntimer = Timer.new()
var period = 5
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	randomize()
	spawntimer.wait_time = period
	if (!enabled):
		spawntimer.stop()

func enable():
	spawntimer.start()
func disable():
	spawntimer.stop()
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_SpawnTimer_timeout():
	var object = object_instance.instance()
	$PathFollow2D.offset = randi()
	object.position = $PathFollow2D.position
	spawntimer.
