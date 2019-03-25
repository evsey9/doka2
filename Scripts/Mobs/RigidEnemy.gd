extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var hp = 100
var speed = 150
var movespeed =150
var player
var lastpos = Vector2()
var pangle
var movepos = null
var collision
var path = null
var pathi = 0
var sniffrange = 1280
var seerange = sniffrange * 4
var circmove = Curve2D.new()
var simple = 0
var rotspeed = 15000
onready var r = $CollisionShape2D.shape.radius + 1
var angle
onready var nav = $"../Navigation2D"
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	add_to_group("enemy")
	add_to_group("rigid")
	add_to_group("noblock")

func _physics_process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
	var space_state = get_world_2d().direct_space_state
	if len(get_tree().get_nodes_in_group("player")) > 0:
		player = get_tree().get_nodes_in_group("player")[0]
	if (position.distance_to(player.position) <= sniffrange or (position.distance_to(player.position) <= seerange and can_move(player.position, space_state))) and path == null: #$RayCast2D.is_colliding() and path == null:

		var body = player #$RayCast2D.get_collider()
		if body.is_in_group("player"):
			lastpos = body.position
			movepos = lastpos
			#print("AA")
	#if $RayCast2D.is_colliding() == false:
	#	path = nav.get_simple_path(position,player.position)
	if can_move(player.position, space_state):
		path = null
		pathi = 0
	if movepos != null:
		if !can_move(movepos, space_state) and path == null:
		#if !phys_move(movepos) and path == null:
			path = nav.get_simple_path(position,movepos,false)
			if len(path) > 0:
				pathi = 0
				for i in path:
					i = i
				movepos = path[pathi]
				#print(path)
		if path != null and len(path) > 0:
			movepos = path[pathi]
			if position.distance_to(movepos) <= speed*delta * 3:
				#if pathi > 0 + simple:
				#	path = nav.get_simple_path(position,path[pathi],false)
				#	pathi = 0
				#	simple = 1
				pathi += 1
				if pathi > path.size() - 1:
					path = null
					pathi = 0
				#	simple = 0
				#print("PATHI: ", pathi)
	if movepos != null:# and position.distance_to(movepos) >= speed * delta:
		#print("WALK")
		#pangle = get_angle_to(lastpos)

		#move_and_slide(speed*(to_local(movepos)).normalized())
		#$Helper.rotation = to_local(movepos).angle()
		#if rotation < (player.position - self.position).angle():
		if get_angle_to(movepos) >= 0:
			applied_torque = rotspeed
		else:
			applied_torque = -rotspeed
		pass
		#collision = move_and_collide(speed*(to_local(movepos)).normalized()*delta)
		#applied_force = movespeed*((movepos - position).normalized())
		applied_force = movespeed*((Vector2(cos(rotation),sin(rotation))).normalized())*weight
		#print("FORCE: " + str(applied_force))
		#if collision != null:
		#	var newvec = collision.remainder - Vector2(collision.remainder.x * collision.normal.x * -sign(collision.remainder.x), collision.remainder.y * collision.normal.y * -sign(collision.remainder.y))
		#	#print(collision.remainder, " R")
		#	#print(collision.normal, "N")
		#	#print(newvec, "N")
		#	#$Helper.rotation = to_local(movepos).angle()
		#	move_and_collide(newvec.normalized()*speed*delta)

	#if get_slide_count() > 0:
	#	collision = get_slide_collision(0)
	#	if lastpos != null:
	#		#path = $Navigation2D.get_simple_path(Vector2(),to_local(lastpos))
	#		pass
	update()

func take_damage(dmg):
	hp -= dmg
	if hp <= 0:
		die()
	#$Helper/Sprite.material.set_shader_param("is", true)
	modulate.g = 0.0
	modulate.b = 0.0
	$attimer.start()

func can_move(pos, state):
	#return !test_move(transform,speed*(to_local(pos)).normalized())
	#return ($RayCast2D.is_colliding() and $RayCast2D.get_collider().is_in_group("player"))
	var rt = state.intersect_ray(position, pos,self.get_children()+[player]+get_tree().get_nodes_in_group("bullet")+get_tree().get_nodes_in_group("enemy")+get_tree().get_nodes_in_group("noblock"))
	return rt.empty()

func phys_move(pos):
	return !test_motion(pos)


func die():
	queue_free()
func _on_PlayerCollider_body_entered(body):
	if body.is_in_group("player"):
		get_tree().reload_current_scene()


func _draw():
	# This draw a white circle with radius of 10px for each point in the path
	if path != null:
		for p in path:
	        pass
			#draw_circle(to_local(p), 10, Color(1, 1, 1))
		pass
		#draw_circle(to_local(movepos), 10, Color(1, 0, 0))

func _on_attimer_timeout():
	#$Helper/Sprite.material.set_shader_param("is", false)
	modulate.g = 1.0
	modulate.b = 1.0