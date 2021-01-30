extends Node2D

var tile = preload("res://puzzles/mazeTile.tscn")

var rng = RandomNumberGenerator.new()
var astar = AStar2D.new()
var mazeWidth = 10
var mazeHeight = 15

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	var maze = generate_maze()
	print_maze(maze)
	build_maze(maze)
#creates a maze with 1 path from top left to bottom right
#assigns random numbers to each square in the array
#runs an a* algorithm to create a path
func generate_maze():
	# Build the tile map of deadly tiles
	var maze = []
	var astarID = 0
	for y in range(mazeHeight):
		maze.append([])
		for x in range(mazeWidth):
			maze[y].append(0) # TODO: change to placing deadly tile
			astar.add_point(astarID, Vector2(x,y), rng.randi())
			if astarID != 0 and x != 0:
				astar.connect_points(astarID, astarID - 1)
			if astarID >= mazeWidth:
				astar.connect_points(astarID, astarID - mazeWidth)
			astarID += 1
	#Calculate Path
	var safePath = astar.get_point_path(0, mazeWidth * mazeHeight - 1)
	#Add the safe tiles to maze
	for safeTile in safePath:
		maze[safeTile.y][safeTile.x] = 1 #TODO: replace with safe tile
	return maze

func print_maze(maze):
	for y in range(mazeHeight):
		print(maze[y])
	print("\n")

func build_maze(maze):
	for y in range(mazeHeight):
		for x in range (mazeWidth):
			var tile_instance = tile.instance()
			tile_instance.position = Vector2((x * 64) + 64, (y * 64) + 64)
			if maze[y][x] == 1:
				tile_instance.makeSafe()
			add_child(tile_instance)
