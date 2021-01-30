extends Node

const GRID_DIMENSION = 3

var solution = null

func _ready():
	solution = simon_says_rng(GRID_DIMENSION * GRID_DIMENSION)
	print(solution)
	process_step(solution[0])
	print(solution)
	process_step(solution[0])
	print(solution)
	
func process_step(id):
	# id should be mapped to the cell of the grid
	var current = solution.pop_front()
	if id == current:
		# likely need to light up the cell with a different color
		check_solved()
		return true
	reset_simon_says()
	return false

func reset_simon_says():
	# also needs to reset the cells of the grid to the starting state
	solution = simon_says_rng(GRID_DIMENSION * GRID_DIMENSION)

func check_solved():
	if solution.empty():
		# do whatever needs to be done for win condition
		pass
	return

func simon_says_rng(size):
	# use size parameter to decide linear size of the simon says grid 
	randomize() # generate a new seed for the internal godot rng
	var puzzle = []
	var rng = null
	while puzzle.size() < size:
		rng = randi() % size # generate number between 0 and size param
		while puzzle.has(rng): # loop to increment until rng is a number not in the array
			rng += 1
			if rng >= size:
				rng = 0
		puzzle.append(rng)
	return puzzle
	
