extends Node2D
var gun_name = "AK-747"
var projectile_type = "grenade"
var fire_time : float = 0.1
var bulletscene = load("res://Scenes/Projectiles/" + projectile_type + ".tscn")
var bullet_speed : int = 1024
var spread_factor = 1
var speed_rand = 50
var held = false
var canfire = true
var bullet_amount : int = 1
var weapontimer : Timer = Timer.new()

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	randomize()
	# Called when the node is added to the scene for the first time.
	# Initialization here
	weapontimer.connect("timeout", self, "able_shoot")
	weapontimer.wait_time = fire_time
	weapontimer.one_shot = true
	weapontimer.process_mode = Timer.TIMER_PROCESS_PHYSICS
	add_child(weapontimer)
	$topsprite/gunname.text = gun_name
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func shoot(pos, rot, speed):
	if canfire:
		for i in range(bullet_amount):
			var bullet = bulletscene.instance()
			bullet.position = pos
			bullet.rotation = rot + deg2rad(rand_range(-spread_factor,spread_factor))
			bullet.speed = speed + rand_range(-speed_rand,speed_rand)
			$"../../".add_child(bullet)
			if (bullet.is_in_group("rigid")):
				bullet.fire()
		canfire = false
		weapontimer.start()

func _on_pickupcollider_body_entered(body):
	add_to_group("held_guns")
	$"../".remove_child(self)
	held = true
	$topsprite.visible = false
	$pickupcollider.call_deferred("set_monitoring",false)
	position = Vector2(0,0)
	body.get_gun(self)

func able_shoot():
	canfire = true