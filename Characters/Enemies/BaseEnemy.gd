extends 'res://Characters/Character.gd'



func _ready():
	max_health = 10
	._ready()
	$UI/HealthProgress.max_value = max_health
	$UI/HealthProgress.value = current_health

func take_damage(damage):
	.take_damage(damage)
	$UI/HealthProgress.value = current_health
	