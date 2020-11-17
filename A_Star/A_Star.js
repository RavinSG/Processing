var rows = 24;
var cols = 45;
var grid = new Array(cols);
var w;
var h;
var start;
var end;
var current;
var openSet = [];
var closedSet = [];
var path = [];

function Cell(i, j) {
    this.x = i;
    this.y = j;
    this.f = 0;
    this.g = 0;
    this.h = 0;
    this.neighbours = [];
    this.visited = false;
    this.finished = false;
    this.previous = undefined;
    this.wall = false;

    if (random(1) < 0.4) {
        this.wall = true;
    }

    this.show = function (col) {
        if (this.wall) {
            fill(0);
        } else {
            fill(col);
        }
        noStroke();
        rect(this.x * w, this.y * h, w - 1, h - 1);
    };

    this.addNeighbours = function (grid) {
        if (this.x > 0) {
            this.neighbours.push(grid[this.x - 1][this.y]);
        }
        if (this.y > 0) {
            this.neighbours.push(grid[this.x][this.y - 1]);
        }
        if (this.x < cols - 1) {
            this.neighbours.push(grid[this.x + 1][this.y]);
        }
        if (this.y < rows - 1) {
            this.neighbours.push(grid[this.x][this.y + 1]);
        }
        if (this.x > 0 && this.y > 0) {
            this.neighbours.push(grid[this.x - 1][this.y - 1]);
        }
        if (this.x < cols - 1 && this.y > 0) {
            this.neighbours.push(grid[this.x + 1][this.y - 1]);
        }
        if (this.x < cols - 1 && this.y < rows - 1) {
            this.neighbours.push(grid[this.x + 1][this.y + 1]);
        }
        if (this.x > 0 && this.y < rows - 1) {
            this.neighbours.push(grid[this.x - 1][this.y + 1]);
        }
    };
}

function removeFromArray(arr, elt) {
    for (i = arr.length - 1; i >= 0; i--) {
        if (arr[i] === elt) {
            arr.splice(i, 1);
        }
    }
}

function heuristic(cell, end) {
    var d = dist(cell.x, cell.y, end.x, end.y);
    return d;
}

function setup() {
    createCanvas(1500, 800);
    w = width / cols;
    h = height / rows;

    for (var i = 0; i < cols; i++) {
        grid[i] = new Array(rows);
    }
    for (var i = 0; i < cols; i++) {
        for (var j = 0; j < rows; j++) {
            grid[i][j] = new Cell(i, j);
        }
    }
    for (var i = 0; i < cols; i++) {
        for (var j = 0; j < rows; j++) {
            grid[i][j].addNeighbours(grid);
        }
    }

    start = grid[0][0];
    start.wall = false;
    start.visited = true;
    end = grid[cols - 1][rows - 1];
    end.wall = false;

    openSet.push(start);
}

function draw() {
    background(0);

    for (var i = 0; i < cols; i++) {
        for (var j = 0; j < rows; j++) {
            grid[i][j].show(255);
        }
    }

    if (openSet.length > 0) {
        var lowestIndex = 0;
        for (i = 0; i < openSet.length; i++) {
            if (openSet[i].f < openSet[lowestIndex].f) {
                lowestIndex = i;
            }
        }
        current = openSet[lowestIndex];

        if (current === end) {
            noLoop();
            console.log('Finished');
        }

        for (i = 0; i < current.neighbours.length; i++) {
            var neighbour = current.neighbours[i];
            if (!neighbour.visited && !neighbour.wall) {
                openSet.push(neighbour);
                neighbour.g = current.g + 1;
                neighbour.h = heuristic(neighbour, end);
                neighbour.visited = true;
                neighbour.previous = current;
            }
            if (!neighbour.finished) {
                if (neighbour.g > current.g + 1) {
                    neighbour.g = current.g + 1;
                    neighbour.previous = current;
                }
            }
            neighbour.f = neighbour.g + neighbour.h;
        }
        current.finished = true;
        removeFromArray(openSet, current);
        closedSet.push(current);

    } else {
        console.log('No Solution');
    }

    for (i = 0; i < openSet.length; i++) {
        openSet[i].show(color(0, 255, 0));
    }

    for (i = 0; i < closedSet.length; i++) {
        closedSet[i].show(color(255, 0, 0));
    }

    var temp = current;
    path.push(temp);
    while (temp.previous) {
        path.push(temp.previous);
        temp = temp.previous;
    }
    for (i = 0; i < path.length; i++) {
        path[i].show(color(0, 0, 255));
    }
    path = [];
    end.show(color(0,125,255));
}
