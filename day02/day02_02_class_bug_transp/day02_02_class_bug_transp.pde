
import toxi.geom.*; // importa la libreria Toxi

/*
primitives:
 float < numeri in virgola mobile
 int < numeri interi
 boolean < valori booleani (true o false)
 
 */

Bug a, b; // dichiarazione di un oggetto della classe Bug
// tipo di dati   nome
//          |     |
ArrayList <Bug> bugs; // dichiarazione ArrayList
PGraphics tr;

PImage logo;

int nBugs = 100; // number of bugs
float d;

void setup() {
  size(800, 700); // dimensione del canvas
  // size(displayWidth, displayHeight); // full screen cmd+shift+R
  smooth();
  
  logo = loadImage("RUFA_logo_80.png");
  
  
  tr = createGraphics(width, height, JAVA2D);
  tr.smooth(8);
  tr.beginDraw();
  tr.endDraw();
  
  bugs = new ArrayList <Bug>(); // instanziazione ArrayList
  ellipseMode(CENTER);
  for (int i=0; i<nBugs; i++) {
    // println(i);
    // a = new Bug(width * 0.5, height * 0.5, 10);
    // Vec2D v = new Vec2D(random(width), random(height));
    Vec2D v = new Vec2D(width*0.5, height*0.5);
    a = new Bug(v, random(20, 50), random(0.005, 0.01), 
    color(0,0,random(255)), color(255));
    bugs.add(a);
  }

  // a = new Bug(width * 0.5, height * 0.5, 10); // instantiation
  // b = new Bug(width * 0.3, height * 0.8, 30); 
  // d = average(6, 7.3);

}

void draw() {
  image(tr,0,0);
  tr.beginDraw();
  for (int i=0; i<bugs.size(); i++) {
    a = bugs.get(i);
    a.update();
    a.display(tr);
  }
  tr.endDraw();
  
  image(logo, width-100, height-100);
}

float average(float a, float b) {
  //float c = (a+b)/2;
  return ((a+b)/2);
}

void keyPressed(){
 if (key == 'i') tr.save("images/bugs_"+ nf(frameCount,4) +".png");
}

