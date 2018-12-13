extends 'res://Characters/Character.gd'

signal attack_cooldown_started

var direction = Vector2()
var rotation_speed = 1.0


enum {ATTACK_LEFT, ATTACK_RIGHT}
var next_attack_type = ATTACK_LEFT
var weapon = null
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	var damage_multiplier = 1.0

	max_health = Player.max_health
	current_health = Player.current_health
	health_regen = Player.health_regen
	
	speed = Player.speed
	speed_multiplier = Player.speed_multiplier
	
	# attack modifiers
	life_steal = Player.life_steal
	crit_chance = Player.crit_chance
	crit_multiplier = Player.crit_multiplier
	
	attack_speed = Player.attack_speed
	attack_cooldown = Player.attack_cooldown
	
	attack_damage = Player.attack_damage
	attack_lower_dispersion = Player.attack_lower_dispersion
	attack_higher_dispersion = Player.attack_higher_dispersion
	
	
	can_attack = true
	$Attack_timer.connect('timeout', self, "_on_Attack_timer_timeout")
	$Attack_cooldown.connect('timeout', self, '_on_Attack_cooldown_timeout')
	weapon = $WeaponPosition/WeaponSpawn.get_children()[0]


func change_direction():
	direction = Vector2(0, 0)
	if Input.is_action_pressed('move_up'):
		direction.y -= 1
	if Input.is_action_pressed('move_down'):
		direction.y += 1
	if Input.is_action_pressed('move_right'):
		direction.x += 1
	if Input.is_action_pressed('move_left'):
		direction.x -= 1
	direction = direction.normalized()

func move(): 
	var desired_velocity = direction * speed * speed_multiplier
	# position += desired_velocity
	move_and_collide(desired_velocity)


func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	if Input.is_action_pressed('mouse_click') and can_attack:
		can_attack = false
		$Attack_timer.wait_time = attack_speed
		$Attack_timer.start()
		
		weapon.start_attack(attack_damage, attack_speed)
		var weapon_rotation = $WeaponPosition.rotation
		if next_attack_type == ATTACK_LEFT:
			$Tween.interpolate_property($WeaponPosition, 'rotation', weapon_rotation, weapon_rotation + deg2rad(178), attack_speed, Tween.TRANS_BACK, Tween.EASE_IN)
			next_attack_type = ATTACK_RIGHT
		else:
			$Tween.interpolate_property($WeaponPosition, 'rotation', weapon_rotation, weapon_rotation - deg2rad(178), attack_speed, Tween.TRANS_BACK, Tween.EASE_IN)
			next_attack_type = ATTACK_LEFT
		$Tween.start()
	change_direction()
	move()
	var mouse_pos =get_local_mouse_position()
	rotation += mouse_pos.angle() * 0.04
	mouse_pos = Vector2(mouse_pos[0], mouse_pos[1]).normalized()
	$WeaponPosition/WeaponSpawn.rotation = mouse_pos.angle() * 0.8

func _on_Attack_timer_timeout():
	$Attack_cooldown.wait_time = attack_cooldown
	emit_signal('attack_cooldown_started', attack_cooldown)
	$Attack_cooldown.start()

func _on_Attack_cooldown_timeout():
	print('can attack')
	can_attack = true