extends KinematicBody2D
var sprgun = preload("res://Sprites/Player/Person.png")
var sprnogun = preload("res://Sprites/Player/PersonNogun.png")
var up
var down
var left
var right
var sh
var speed : float = 256.0
var mousepos : Vector2 = Vector2()
const FLASHTIMER = 0.02
var flashtimer = FLASHTIMER
var flash = false
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	randomize()

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
	#print(delta)
	mousepos = get_global_mouse_position()
	$helper.rotation = (mousepos - position).angle()
	up = Input.is_action_pressed("player_up")
	down = Input.is_action_pressed("player_down")
	left = Input.is_action_pressed("player_left")
	right = Input.is_action_pressed("player_right")
	sh = Input.is_action_pressed("player_shoot")
	var mv : Vector2 = Vector2(0,  0)
	mv += int(up)*Vector2(0, -1)
	mv += int(down)*Vector2(0, 1)
	mv += int(left)*Vector2(-1, 0)
	mv += int(right)*Vector2(1, 0)
	mv = mv.normalized()
	move_and_slide(mv*speed)
	if sh: #and canfire:
		shoot()
		#canfire = false
		#weptimer = bweptimer
#	if !canfire:
#		weptimer -= delta
#		if weptimer < 0:
#			canfire = true
	if flash:
		if flashtimer <= 0:
			flashtimer = FLASHTIMER
			flash = false
			$helper/Sprite.frame = 0
		else:
			# print(flashtimer)
			flashtimer -= delta
	
func shoot():
	flash = true
	$helper/Sprite.frame = 1
	get_tree().call_group("held_guns","shoot",$helper/bulPos.global_position,$helper.rotation + deg2rad(rand_range(-1,1)),1024)
#	var bullet = bulletscene.instance()
#	bullet.position = $helper/bulPos.global_position
#	bullet.rotation = $helper.rotation + deg2rad(rand_range(-1,1))
#	bullet.speed = bspeed + rand_range(-10,10)
#	$"../".add_child(bullet)
	
func get_gun(gun):
	add_child(gun)
	$helper/Sprite.texture = sprgun