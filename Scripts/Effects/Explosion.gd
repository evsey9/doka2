extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var blastpower = 1000000
var blastdist = 150
var dmgmod = 0.05
var phys = true
# Called when the node enters the scene tree for the first time.
func _ready():
	if phys:
		expleffects()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func apply_blast_impulse(body : RigidBody2D, blastCenter : Vector2, applyPoint : Vector2, blastPower : float):
	var blastDir : Vector2 = applyPoint - blastCenter
	var distance : float = blastDir.length()
	if distance == 0:
		return
	var invDistance : float = 1 / distance
	var impulseMag : float = blastPower * invDistance * invDistance
	print("impmag: "+str(impulseMag))
	body.apply_central_impulse(blastDir * impulseMag)
	if body.is_in_group("enemy"):
		body.take_damage(impulseMag * dmgmod )

func expleffects():
	var objs = get_tree().get_nodes_in_group("rigid")
	for i in objs:
		if position.distance_to(i.position) <= blastdist and !i.is_in_group("grenade"):
			apply_blast_impulse(i, position, i.position, blastpower)
func explode():
	queue_free()
	
