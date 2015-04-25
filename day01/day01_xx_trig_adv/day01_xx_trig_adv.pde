/*

 P5 ws RUFA
 
 tutor: Alessio Erioli - Co-de-iT
 
 Playing with (not so) basic trigonometry
 
 trigonometry isn't so difficult after all!
 
 Mouse click toggle between 3 cases:
 
 0 - simple sin/cos curves diagram
 1 - draw with color spot, sin/cos used to generate a pulse
 2 - point at target with atan2 function
 
 */

import toxi.geom.*;

Vec2D p;
float inc = 2;
int mode = 0;

void setup() {
  size(1500, 400);

  stroke(255, 0, 0);
  strokeWeight(5);
  background(0);
  p = new Vec2D (0, height*0.5);
  noCursor();
  //cursor(CROSS);
}


void draw() {
  switch(mode) {
  case 0:
    diagram();
    break;
  case 1:
    spot();
    break;
  case 2:
    pointAt();
    break;
  }
}

void diagram() {
  point(p.x, p.y);
  point(width*0.5, p.y);
  point(p.x, height*0.5);
  p.x += inc;
  if (p.x > width) p.x=0;
  p.y = height*0.5 + sin(frameCount*0.1)*(height*0.3);
  pushStyle();
  noStroke();
  fill(0, 10);
  rect(0, 0, width, height); 
  popStyle();
}

void spot() {
  pushStyle();
  stroke(255);
  strokeWeight(0.5);
  fill(0, 255, 255);
  float diam = cos(frameCount*0.05)*30;
  ellipse(mouseX, mouseY, 40+diam, 40+diam);
  popStyle();
}

void pointAt() {
  background(0);
  pushStyle();
  stroke(255);
  point(p.x, p.y);
  // orientation angle towards target
  // use atan2(target.Y - current.Y, target.X - current.X)
  float angle = atan2(p.y-mouseY, p.x-mouseX);

  pushMatrix();
  // go to position
  translate(mouseX, mouseY);
  // orient towards target
  rotate(angle);
  stroke(255,0,0);
  line(0, 0, 50, 0);
  popMatrix();

  p.x += inc;
  if (p.x > width) p.x=0;
  p.y = height*0.5 + sin(frameCount*0.05)*(height*0.3);
  popStyle();
}

void mousePressed() {
  mode = (mode+1)%3;
  if (mode==1) background(0); // cleans background before going in mode 1
}
