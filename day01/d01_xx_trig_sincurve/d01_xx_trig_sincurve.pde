/*

 P5 ws RUFA
 
 tutor: Alessio Erioli - Co-de-iT
 
 some trigonometry basics - sinusoid and Lissajous curve
 
 */

import toxi.geom.*;

Vec2D v, v1;
float freq = 0.05;

void setup() {

  size(900, 300, P2D);
  smooth();
  v = new Vec2D();
  v1 = new Vec2D();
  background(0);
  noStroke();
}

void draw() {
  fill(255);
  // sinusoid curve
  v.x = (v.x+50*freq) % width;
  v.y = height/2 * (1+sin(frameCount*freq));
  // Lissajous curve - http://mathworld.wolfram.com/LissajousCurve.html
  v1.x = width/2 + height/2 * cos(frameCount*freq*0.63);
  v1.y = v.y;
  
  // display
  ellipse(v.x, v.y, 5, 5);
  fill(255, 0, 0);
  ellipse(v1.x, v1.y, 5, 5);
  fill(0, 30);
  rect(0, 0, width, height);
}
