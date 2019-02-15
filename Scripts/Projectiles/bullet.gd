extends KinematicBody2D
var destroytimer = Timer.new()
# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var collis
var speed = 10
var refchance = 10
var refdegree = 15
var mvector = Vector2()
var pushforce = 5
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	randomize()
	add_to_group("bullet")
	destroytimer.connect("timeout", self, "queue_free")
	destroytimer.one_shot = true
	destroytimer.process_mode = Timer.TIMER_PROCESS_PHYSICS
	add_child(destroytimer)

func _physics_process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
	mvector = speed*delta*Vector2(cos(rotation),sin(rotation))
	collis = move_and_collide(mvector)
	$Tracer.points = PoolVector2Array([Vector2(0,0),mvector.length()*0*Vector2(-1,0)])
	if collis != null:
		var relangle = abs(Vector2(cos(rotation),sin(rotation)).angle_to(-collis.normal))
		#print("rot: " + str(Vector2(cos(rotation),sin(rotation))))
		#print("normal: "+ str(collis.normal))
		#print(rad2deg(relangle))
		if rad2deg(relangle) > 90 - refdegree and randi() % 100 > 100 - refchance:
			var rotvec = Vector2(-cos(rotation),-sin(rotation))
			rotvec = rotvec.reflect(collis.normal)
			rotation = rotvec.angle()
			#print("REF")
		else:
			pass
			queue_free()

func _on_EnemyCollider_body_entered(body):
	if body.is_in_group("enemy"):
		if body.is_in_group("rigid"):
			body.apply_impulse(position,mvector.normalized()*pushforce)
		body.take_damage(25)
	#queue_free()
	destroy(5)

func destroy(time):
	set_physics_process(false)
	$Tracer.queue_free()
	$Sprite.queue_free()
	$EnemyCollider.queue_free()
	$Blood.emitting = true
	destroytimer.wait_time = time
	destroytimer.start()