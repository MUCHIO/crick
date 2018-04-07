var cellSize = 5;

var probabilityOfAliveAtStart = 15;

var interval = 100;
var lastRecordedTime = 0;

var alive;
var dead;

var cells;
var cellsBuffer;

var pause = false;

function make2DArray(cols,rows) {
 var arr = new Array(cols);
 for (var i = 0; i < cols; i++) {
   arr[i] = new Array(rows);
 }
 return arr;
}

function setup() {
 var canvas = createCanvas(1000, 500);
 canvas.parent("p5container");
 alive = color(0, 200, 0);
 dead = color(0);

 cells = make2DArray(width/cellSize, height/cellSize);
 cellsBuffer =  make2DArray(width/cellSize, height/cellSize);

 stroke(48);

 noSmooth();

 for (var x=0; x<width/cellSize; x++) {
   for (var y=0; y<height/cellSize; y++) {
     var state = random (100);
     if (state > probabilityOfAliveAtStart) {
       state = 0;
     }
     else {
       state = 1;
     }
     cells[x][y] = state;
   }
 }
 background(0);
}


function draw() {

 for (var x=0; x<width/cellSize; x++) {
   for (var y=0; y<height/cellSize; y++) {
     if (cells[x][y]==1) {
       fill(alive);
     }
     else {
       fill(dead);
     }
     rect (x*cellSize, y*cellSize, cellSize, cellSize);
   }
 }
 if (millis()-lastRecordedTime>interval) {
   if (!pause) {
     iteration();
     lastRecordedTime = millis();
   }
 }

 if (pause && mouseIsPressed) {
   var xCellOver = int(map(mouseX, 0, width, 0, width/cellSize));
   xCellOver = constrain(xCellOver, 0, width/cellSize-1);
   var yCellOver = int(map(mouseY, 0, height, 0, height/cellSize));
   yCellOver = constrain(yCellOver, 0, height/cellSize-1);

   if (cellsBuffer[xCellOver][yCellOver]==1) {
     cells[xCellOver][yCellOver]=0;
     fill(dead);
   }
   else {
     cells[xCellOver][yCellOver]=1;
     fill(alive);
   }
 }
 else if (pause && !mouseIsPressed) {
   for (var x=0; x<width/cellSize; x++) {
     for (var y=0; y<height/cellSize; y++) {
       cellsBuffer[x][y] = cells[x][y];
     }
   }
 }
}

function iteration() {

 for (var x=0; x<width/cellSize; x++) {
   for (var y=0; y<height/cellSize; y++) {
     cellsBuffer[x][y] = cells[x][y];
   }
 }

 for (var x=0; x<width/cellSize; x++) {
   for (var y=0; y<height/cellSize; y++) {
     var neighbours = 0;
     for (var xx=x-1; xx<=x+1;xx++) {
       for (var yy=y-1; yy<=y+1;yy++) {
         if (((xx>=0)&&(xx<width/cellSize))&&((yy>=0)&&(yy<height/cellSize))) {
           if (!((xx==x)&&(yy==y))) {
             if (cellsBuffer[xx][yy]==1){
               neighbours ++;
             }
           }
         }
       }
     }

     if (cellsBuffer[x][y]==1) {
       if (neighbours < 2 || neighbours > 3) {
         cells[x][y] = 0;
       }
     }
     else {
       if (neighbours == 3 ) {
         cells[x][y] = 1;
       }
     }
   }
 }
}

 if (key==' ') {
   pause = !pause;
 }
 if (key=='c' || key == 'C') {
   for (var x=0; x<width/cellSize; x++) {
     for (var y=0; y<height/cellSize; y++) {
       cells[x][y] = 0;
     }
   }
 }
