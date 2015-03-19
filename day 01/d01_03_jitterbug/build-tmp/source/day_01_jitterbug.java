import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class day_01_jitterbug extends PApplet {


/* 
 
 Oo\u00b0 - Object Oriented Ornament
 P5 Co-de-iT workshop Cava dei Tirreni - 22>24 November 2013
 tutor: Alessio Erioli
 
 Jitterbug - simple class example with cascade constructors
 
 */

JitterBug bug, bug2, spencer, hill;

public void setup() {
  size(400, 700);
  smooth();
  //                         loc             diam  speed     col
  bug = new JitterBug (new PVector(150, 450), 80, 3, color(200, 8, 50));
  bug2 = new JitterBug (new PVector(150, 450), 30, 5, color(0xffFFFF00));
  spencer = new JitterBug(new PVector(random(width), random(height)), 50, 4, color(210, 210, 210));
  hill = new JitterBug();
  background(130);
  //noStroke();
  println("new Jitterbug created in x: ", bug.loc.x, ", y: ", bug.loc.y);
}

public void draw() {

  bug.update();
  bug2.update();
  spencer.update();
  hill.update();
}

public void keyPressed() {
  if (key=='i') saveFrame("images/JitterBugs_####.png");
}

class JitterBug {

  // fields - class properties
  PVector loc;
  float diam;
  float speed;
  int col;

  // constructor(s) - how to build class instances
  JitterBug (PVector _loc, float _diam, float _speed, int _col) {
    loc = _loc;
    diam = _diam;
    speed = _speed;
    col = _col;
  }

  // si possono costruire costruttori a cascata, in cui uno solo contiene
  // tutti i parametri definiti dall'utente e gli altri fanno
  // riferimento a quello. Nel nostro caso \u00e8 quello qui sopra.
  // in classe abbiamo dovuto fare il costruttore random cos\u00ec:
  
  /*JitterBug() {
   loc = new PVector(random(width), random(height));
   diam = random(2, 20);
   speed = random(1, 8);
   col = color(random(255), random(255), random(255));
   }*/

  // per chiamare correttamente i costruttori a cascata, tutti gli altri
  // costruttori devono chiamare quello principale con "this" al posto del 
  // nome del costruttore. Vedi qui sotto.
  // qui c'\u00e8 la spiegazione di come chiamare i costruttori a cascata:
  // http://forum.processing.org/two/discussion/463/issue-calling-class-constructor/p1
  // per Java: http://stackoverflow.com/questions/285177/how-do-i-call-one-constructor-from-another-in-java/16080312
  JitterBug() {
    this(new PVector(random(width), random(height)),
    random(2, 20), 
    random(1, 8), 
    color(random(255), random(255), random(255)));
  }

  // methods

  public void update() {
    randoMove();
    respawn();
    display();
  }


  public void display() {
    fill(col);
    ellipse(loc.x, loc.y, 2+sin(frameCount/50.0f)*diam, 2+sin(frameCount/50.0f)*diam);
  }

  public void randoMove() {
    loc.add(new PVector(random(-speed, speed), random(-speed, speed)));
  }

  public void respawn() {
    if (loc.x<0 || loc.x>width || loc.y<0 || loc.y> height)
      loc = new PVector(random(width), random(height));
  }
}

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--full-screen", "--bgcolor=#666666", "--stop-color=#cccccc", "day_01_jitterbug" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
