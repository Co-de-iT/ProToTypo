/*

 P5 ws RUFA
 
 tutor: Alessio Erioli - Co-de-iT
 
object basics + behaviors
 
 click on tab AA_intro for a quick introduction
 
 */



// what's this?
import toxi.geom.*;

/* 
 
 classes can be collected in libraries and can be retrieved for use by importing libraries.
 We are teling Processing that we are going to use external classes
 
 dissecting the command:
 
 toxi.geom.* 
 |    |  |
 |    |  |      
 from toxi   |  ----------
 |            |
 import the geom module   |
 |
 and from toxi.geom import everything (* is a placeholder for "all of it")
 
 */

PImage logo;
Dot p;
ArrayList <Dot> dots;
int nDots = 150;

void setup() {

  size(800, 450, P2D);
  smooth();
  logo = loadImage("RUFA_logo_80.png");
  dots = new ArrayList<Dot>();
  float rad, speed, acc;
  color col;
  for (int i=0; i< nDots; i++) {
    rad = random(5, 50);
    col = color(random(200, 255), random(20, 105), random(255));
    speed = random(-0.2, 0.2);
    acc = random(-0.001, 0.001);
    p = new Dot (new Vec3D(random(width), random(height), 0), rad, col, 0.1, -0.0005);
    dots.add(p);
  }

  noStroke();
  stroke(0);
  background(240);
}

void draw() {
    noStroke();
  for (Dot p : dots) {
    fill(p.col);
    p.update();
    p.display();
  }
  image(logo, width-100, height-100);
}
