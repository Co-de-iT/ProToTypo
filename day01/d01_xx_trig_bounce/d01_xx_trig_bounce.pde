/*

 P5 ws RUFA - trigonometry 2
 
 tutor: Alessio Erioli - Co-de-iT
 
 some trigonometry basics
 
 */

import toxi.geom.*;

Vec2D v, v1;
float freq = 0.04;
float incV = 5;
int drawMode = 0;

void setup() {

  size(400, 400, P2D);
  smooth();
  v = new Vec2D(100, height/2);
  v1 = new Vec2D(300, height/2);
  background(0);
  noStroke();
}

void draw() {

  switch (drawMode) {

  case 0:
    fill(255);
    v.y+=incV;
    if (v.y > height || v.y<0) incV *=-1;

    v1.y = height/2 * (1+sin(frameCount*freq));

    ellipse(v.x, v.y, 5, 5);
    fill(255, 0, 0);
    ellipse(v1.x, v1.y, 5, 5);
    fill(0, 30);
    rect(0, 0, width, height);
    break;
    
    case 1:
    
    background(220);
    fill(200,0,0);
    float diam = 100*cos(frameCount*freq);
    ellipse(width/2,height/2, 150+diam, 150+diam);
    break;
  }
}

void mousePressed() {
  drawMode = (drawMode+1)%2;
}
