extends RigidBody2D
var expleffect = preload("res://Scenes/Effects/Explosion.tscn")
var collis
var speed = 10
var refchance = 10
var refdegree = 15
var forcemult = 1
var primetime = 1.2
var blastpower = 1000000
var blastdist = 150
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.


func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	add_to_group("rigid")
	add_to_group("noblock")
	add_to_group("grenade")
	#set_linear_velocity(Vector2(speed,0))
	randomize()
	set_time(primetime)
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

func fire():
	apply_central_impulse(Vector2(cos(rotation)*speed*forcemult,sin(rotation)*speed*forcemult))
	
func set_time(time : float):
	$ExplosionTimer.start(time)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func explode(): #create actual explosion object to spawn
	var nexp = expleffect.instance()
	nexp.position = position
	nexp.blastdist = blastdist
	nexp.blastpower = blastpower
	nexp.dmgmod = 0.05
	get_parent().add_child(nexp)
	queue_free()

func _on_ExplosionTimer_timeout():
	explode()
	#finish up the code


