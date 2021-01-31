extends Node

func create_push_puzzle(arr_len, boxes_to_push):
	var board = []
	

function createPushPuzzle(Int arrayLength, Int boxesToPush) {
	const boardArray = new Array(length);
	if (boardArray > boxesToPush - 2) {
		return "Error you need at least 2 less boxes than the grid length"
	}

	if (boxesToPush < 3) {
		return "Error you need at least 3 boxes"
	}

	const numberOfSolutionPoints = boxesToPush - 2;

	const solutionPositions = new Array[numberOfSolutionPoints];
	const startPositions = new Array[solutionsTotal]];

	boxesToPush.forEach(boxToPush => {
		let valid = false;
		while (valid = false) {
			const indexToTry = Math.random(0, boardArray.length);
			if(!solutionPositions.includes(indexToTry) && !startPositions.includes(indexToTry)){
				if(solutionPositions.length < numberOfSolutionPoints){
					solutionPositions.push(indexToTry);
					boardArray[indexToTry] = 1;
					valid = true;
				} else {
					startPositions.push(indexToTry);
					boardArray[indexToTry] = 2
					valid = true;
				}
			}
		}
	})

	return boardArray;
}
