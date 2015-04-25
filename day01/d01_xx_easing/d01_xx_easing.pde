/*

 P5 ws RUFA
 
 tutor: Alessio Erioli - Co-de-iT
 
 motion easing - mouse wheel controls threshold value
 
 */

import toxi.geom.*;

PImage logo;

Vec2D p, m, s; 
float thres = 150;
float easing =0.5;
float maxSpeed = 15;
void setup() {
  size(800, 800);
  smooth();
  logo = loadImage("RUFA_logo_80.png");
  p = new Vec2D(width/2, height/2);
  noStroke();
  fill(20);
}


void draw() {
  background(230);
  m = new Vec2D(mouseX, mouseY);
  s = m.sub(p);
  float mag = s.magnitude();

  pushStyle();
  fill(20, 50);
  ellipse(m.x, m.y, thres*2, thres*2);
  popStyle();

  s.normalize();

  if (mag<thres) {
    fill(255);
    s.scaleSelf(maxSpeed*sin(map((mag/thres)*easing, 1, 0, PI/2, 0)));
  } else {
    fill(0);
    s.scaleSelf(maxSpeed);
  }
  p.addSelf(s);
  ellipse(p.x, p.y, 5, 5);

  image(logo, width-100, height-100);
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  thres += e;
  thres = constrain(thres, 20, 250);
}
