extends Node

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

var attack_damage = 1
var attack_lower_dispersion = 0.1
var attack_higher_dispersion = 0.1