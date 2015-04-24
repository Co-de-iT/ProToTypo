
/*

 P5 ws RUFA
 
 tutor: Alessio Erioli - Co-de-iT
 
 basic vector operations
 
 */

import toxi.geom.*;
Vec2D a, b, center, add, sub, norm, scale;
PImage logo;
boolean construct = false;
int txtOffset = 5;

void setup() {

  size(800, 800);
  smooth();
  logo = loadImage("RUFA_logo_80.png");
  a = new Vec2D(random(-width*.5, width *.5), random(-height*.5, height *.5)); 
  center = new Vec2D(width*.5, height*.5);
  // multiplications are faster than divisions; also, .5 is the same as 0.5
  cursor(CROSS);
}

void draw() {
  background(240);
  
  b = new Vec2D(mouseX, mouseY).sub(center); // center vector in the middle of the screen
  add = a.add(b); // addition
  sub= b.sub(a); // subtraction (b-a) - vector arrow is in b
  norm = new Vec2D(b).normalizeTo(10); // normalize or unitize - direction only
  scale = new Vec2D(add).scale(.5); // scale
  stroke(120);
  strokeWeight(.5);
  line(0, center.y, width, center.y);
  line(center.x, 0, center.x, height);

  pushMatrix();
  translate(width*.5, height*.5);
  if (construct) {
    line(a.x, a.y, add.x, add.y);
    line(b.x, b.y, add.x, add.y);
  }
  stroke(255, 0, 0);
  fill(0);
  line(0, 0, a.x, a.y);
  text("A", a.x + txtOffset, a.y - txtOffset);
  stroke(0, 0, 255);
  line(0, 0, b.x, b.y);
  text("B", b.x + txtOffset, b.y - txtOffset);
  stroke(255, 0, 255);
  line(0, 0, add.x, add.y);
  text("A+B", add.x + txtOffset, add.y - txtOffset);
  strokeWeight(4);
  stroke(255);
  line(0, 0, norm.x, norm.y);
  line(0,0,scale.x, scale.y);
  translate(a.x, a.y);
  stroke(0, 200, 200);
  strokeWeight(.5);
  line(0, 0, sub.x, sub.y);

  popMatrix();
  image(logo, width-100, height-100);
}

void keyPressed( ) {
  if (key=='c') {
    construct = !construct;
  }
}
