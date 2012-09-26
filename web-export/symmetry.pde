
float pointsX[];           // array of x coords of points 
float pointsY[];           // array of y coords of points
int circleSize = 2;        // size of circle points
float lastX;      // used to draw lines, holds position of previous point 
float lastY;    //  used to draw lines, holds position of previous point
long lastDraw = 0;         // used to space out drawing lines, tells when the last run happened
int delay = 40;           // time to delay draw in milliseconds
boolean playback = false;  // Toggle whether in drawing mode or playback mode
int R = int(random(0,255));
int B = int(random(0,255));

int i = 1;                 // Iterator used to keep track of position when drawing lines

void setup() {
  size(500, 500); 
  background(0);

  // initialize new arrays of points  
  pointsX = new float[1];
  pointsY = new float[1];

  // assign default first value for first item in array
  pointsX[0] = 0;
  pointsY[0] = 0;

  lastX = pointsX[0];
  lastY = pointsY[0];

  // initialize lastDraw variable
  lastDraw = millis();
}

void draw() {
  
  if (!playback) {
   fill(255);
      // draw points at mouse coords when mouse is clicked. Also draw point at reflected x coords
      fill(R,mouseY%255, B);
      stroke(R,mouseY%255, B);
      ellipse(mouseX, mouseY, circleSize, circleSize);
      ellipse(width-mouseX, mouseY, circleSize, circleSize);

      //stroke(255);

      // connect the dots from last point to current point, same for reflected
//      line(lastX, lastY, mouseX, mouseY);
//      line(width-lastX, lastY, width-mouseX, mouseY);

      // set current point as new last point for connecting dots
      lastX = mouseX;
      lastY = mouseY;

      // append new points to array
      pointsX = (float[]) append(pointsX, lastX);
      pointsY = (float[]) append(pointsY, lastY);

      // DEBUGGING - print length of arrays
      //println(pointsX.length);
      
  }

  // This is triggered when the user presses the 'P' key, for playback
  if (playback) {

    //  Check to see if a second has passed since the last run. Used to space out the drawing
    if (millis() - lastDraw > delay) {

      // Draw circle for endpoint at position held in array, and on the mirrored side as well
      fill(R,pointsY[i]%255, B);
      stroke(R,pointsY[i]%255, B);
      ellipse(pointsX[i], pointsY[i], circleSize, circleSize);

      // width - point is used to mirror the points onto the right side of window
      ellipse(width-pointsX[i], pointsY[i], circleSize, circleSize);

      //stroke(255);

      // connect dots with lines on each side of reflection
//      line(pointsX[i-1], pointsY[i-1], pointsX[i], pointsY[i]);
//      line(width-pointsX[i-1], pointsY[i-1], width-pointsX[i], pointsY[i]);

      // increment iterator
      i = i + 1;

      // set last draw at current millis
      lastDraw = millis();
    } 
    else {

     
    }

    // when iterator reaches length of points arrays, return to draw mode
    if (i == pointsX.length) {
      playback = false;
      i = 1;
    }
  }
}



void mouseClicked() {
//  Changed Direction, decide to go with more fluid idea. Left here for posterity
//
//  // draw points at mouse coords when mouse is clicked. Also draw point at reflected x coords
//  ellipse(mouseX, mouseY, circleSize, circleSize);
//  ellipse(width-mouseX, mouseY, circleSize, circleSize);
//
//  stroke(255);
//
//  // connect the dots from last point to current point, same for reflected
//  line(lastX, lastY, mouseX, mouseY);
//  line(width-lastX, lastY, width-mouseX, mouseY);
//
//  // set current point as new last point for connecting dots
//  lastX = mouseX;
//  lastY = mouseY;
//
//  // append new points to array
//  pointsX = (float[]) append(pointsX, lastX);
//  pointsY = (float[]) append(pointsY, lastY);
//
//  // DEBUGGING - print length of arrays
//  //println(pointsX.length);
}

void keyPressed() {

  // DEBUGGING println(keyCode); 

  // Check for 'P' keypress to begin playback mode 
  if (keyCode == 80) {

    // Begin playback
    playback = true;

    // Set backgorund to black
    background(0);
  }
}


