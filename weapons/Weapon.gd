extends Area2D

var attack_power

enum STATES {IDLE, ATTACK}

var state = null
var damaged_items = []
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	_change_state(STATES.IDLE)
	$Timer.connect("timeout", self, "_on_Timer_timeout")
	
func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		var name = body.get_name()
		if not 'Map' in name: #DIRTY HACK
			var id = body.get_rid().get_id()
			if not id in damaged_items and not body.is_a_parent_of(self):
				damaged_items.append(id)
				if body.has_method("take_damage"):
					body.take_damage(attack_power)

func start_attack(damage, attack_speed):
	attack_power = damage
	_change_state(STATES.ATTACK)
	$Timer.wait_time = attack_speed
	$Timer.start()
	

func _change_state(new_state):
	print('changed state weapon')
	match new_state:
		STATES.IDLE:
			$CollisionShape.disabled = true
			set_physics_process(false)
		STATES.ATTACK:
			damaged_items = []
			$CollisionShape.disabled = false
			set_physics_process(true)

func _on_Timer_timeout():
	_change_state(STATES.IDLE)