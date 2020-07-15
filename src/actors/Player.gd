extends KinematicBody2D

 
const GRAVITY = 50
const MAX_FALL_SPEED = 1000
const MOVE_SPEED = 500
const JUMP_FORCE = 1000


signal shoot


export (PackedScene) var Bullet
export (float) var gun_cooldown
var can_shoot = true
var y_velo = 0
var in_poison = false


func _ready():
	$GunTimer.wait_time = gun_cooldown
	$Gun.visible = PlayerVariables.has_gun
	PlayerVariables.camera = $Camera2D
	PlayerVariables.player = self
	$DeathSound.play()



func _input(event):
	if event is InputEventMouseMotion:
		$Gun.look_at(get_global_mouse_position())

	if event is InputEventKey and (event as InputEventKey).scancode == KEY_ESCAPE:
		get_tree().quit()


func _physics_process(delta):
	if Input.is_action_pressed("reload"):
		reload()

	var move_dir = 0
	if Input.is_action_pressed("ui_right"):
		move_dir += 1
	if Input.is_action_pressed("ui_left"):
		move_dir -= 1
	move_and_slide(Vector2(move_dir * MOVE_SPEED, y_velo), Vector2.UP)

	var grounded = is_on_floor()
	y_velo += GRAVITY
	if grounded and Input.is_action_just_pressed("ui_up"):
		y_velo = -JUMP_FORCE
	if PlayerVariables.left_creature:
		PlayerVariables.left_creature = false
		y_velo = -JUMP_FORCE
	if grounded and y_velo >= 5:
		y_velo = 5
	if y_velo > MAX_FALL_SPEED:
		y_velo = MAX_FALL_SPEED

	var joystick_dx = Input.get_joy_axis(0, 2)
	var joystick_dy = Input.get_joy_axis(0, 3)
	var joystick_vec = Vector2(joystick_dx, joystick_dy)
	if joystick_vec.length() > 0.5:
		$Gun.rotation = joystick_vec.angle()

	if Input.is_action_just_pressed('click') and PlayerVariables.has_gun and can_shoot:
		shoot()
	
	if in_poison and not PlayerVariables.poison_resistant:
		die()


func shoot():
	$BeamSound.play()
	$GunTimer.start()

	$Gun/RayCast2D.force_raycast_update()
	if $Gun/RayCast2D.is_colliding():
		emit_signal("shoot", $Gun/RayCast2D.get_collider(), $Gun.global_position, $Gun/RayCast2D.get_collision_point())
	
	can_shoot = false


func reload():
	die()


func die():
	get_tree().reload_current_scene()


func pickup_gun():
	$Gun.visible = true
	can_shoot = true


func _on_GunTimer_timeout():
	can_shoot = true


func _on_DeathZone_body_entered(body):
	in_poison = true


func _on_GunPickup_body_entered(body):
	pickup_gun()


func _on_EnemyDetector_body_entered(body):
	die()


func _on_DeathZone_body_exited(body):
	in_poison = false
