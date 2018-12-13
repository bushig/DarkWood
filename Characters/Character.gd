extends KinematicBody2D


enum STATES {IDLE, MOVING}


signal attack_speed_changed
signal attack_cooldown_changed

signal max_health_changed
signal damage_multiplier_changed

var damage_multiplier = 1.0

var max_health = 1
var current_health = 1
var health_regen = null

var speed = 1.2
var speed_multiplier = 1.0

# attack modifiers
var life_steal = null
var crit_chance = 0.0
var crit_multiplier = 1.00

var can_attack = true
var attack_speed = 0.5
var attack_cooldown = 1.0

var attack_damage = 0
var attack_lower_dispersion = 0.1
var attack_higher_dispersion = 0.1

func _ready():
	current_health = max_health

func die():
	$DeathParticles.emitting = true
	$Hitbox.disabled = true
	$Tween.stop_all()
	$BodySprite.modulate = Color(0.7, 0, 0, 0.5)

func take_damage(damage):
	print('HAVE TEKEN DAMAGE', damage)
	current_health -= damage
	if current_health <= 0:
		current_health = 0
		print('DIED')
		die()

