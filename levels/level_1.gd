extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	var data = LevelGen.Generate()
	$FloorMap.clear()
	$WallMap.clear()
	print(data.start_pos*32)
	$Player.position = data.start_pos*32
	draw_map(data.map)
	

func draw_map( map ):
	for x in range( map.size() ):
		for y in range( map[x].size() ):
			if map[x][y] == 1:
				$FloorMap.set_cell( x,y, 0 )
			else:
				$WallMap.set_cell(x, y, 0)