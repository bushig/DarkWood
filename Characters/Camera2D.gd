extends Camera2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var zoom_ration = 0.7
var max_zoom = 10 # Change to 0.7
var min_zoom = 0.1

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	#set_process_input(true)
	pass

func _input(event):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	# print('res')
	if Input.is_action_just_pressed("wheel_up"):
		if zoom_ration >= min_zoom:
			zoom_ration -= 0.05
		set_zoom(Vector2(zoom_ration, zoom_ration))
	elif Input.is_action_just_pressed("wheel_down"):
		if zoom_ration <= max_zoom:
			zoom_ration += 0.05
		set_zoom(Vector2(zoom_ration, zoom_ration))
		