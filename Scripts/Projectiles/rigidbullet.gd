extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var collis
var speed = 10
var refchance = 10
var refdegree = 15
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	set_linear_velocity(Vector2(speed,0))
	randomize()

func _physis_process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	pass
#	var mvector = speed*delta*Vector2(cos(rotation),sin(rotation))
#	collis = move_and_collide(mvector)
#	$Tracer.points = PoolVector2Array([Vector2(0,0),mvector.length()*0*Vector2(-1,0)])
#	if collis != null:
#		var relangle = abs(Vector2(cos(rotation),sin(rotation)).angle_to(-collis.normal))
#		#print("rot: " + str(Vector2(cos(rotation),sin(rotation))))
#		#print("normal: "+ str(collis.normal))
#		#print(rad2deg(relangle))
#		if rad2deg(relangle) > 90 - refdegree and randi() % 100 > 100 - refchance:
#			var rotvec = Vector2(-cos(rotation),-sin(rotation))
#			rotvec = rotvec.reflect(collis.normal)
#			rotation = rotvec.angle()
#			#print("REF")
#		else:
#			pass
#			queue_free()