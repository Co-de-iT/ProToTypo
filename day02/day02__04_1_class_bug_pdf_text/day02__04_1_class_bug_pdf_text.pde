
import toxi.geom.*; // importa la libreria Toxi
import processing.pdf.*;

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
PGraphics tr, pg;
String text = "RUFA";
PFont font;

int nBugs = 100, countBug; // number of bugs
float d;
boolean recordPdf = false; // set to true before running the sletch to record the pdf

void setup() {
  size(1400, 700); // dimensione del canvas
  // size(displayWidth, displayHeight); // full screen cmd+shift+R
  smooth(8);
  font = createFont("OpenSans-Bold", 80);

  // pg è dove scriveremo il testo
  pg = createGraphics(width, height, JAVA2D);
  pg.beginDraw();
  pg.textFont(font);
  pg.textSize(400);
  pg.textAlign(CENTER, CENTER);
  pg.fill(0);
  pg.text(text, pg.width*0.5, pg.height*0.5);
  pg.endDraw();

  // tr è dove andremo a disegnare
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
    // Vec2D v = new Vec2D(width*0.5, height*0.5);
    a = new Bug(random(5, 10), random(0.02, 0.01), 
    color(0, 0, random(255)), color(255));
    bugs.add(a);
  }

  // a = new Bug(width * 0.5, height * 0.5, 10); // instantiation
  // b = new Bug(width * 0.3, height * 0.8, 30); 
  // d = average(6, 7.3);
  
 
  beginRecord(PDF, "PDF/test_4.pdf");
  strokeWeight(0.5);
}

void draw() {
  //image(pg,0,0);
  countBug=0;
  //image(tr, 0, 0);
  // text(text, width*0.5, height*0.5);
  
  for (int i=0; i<bugs.size (); i++) {
    a = bugs.get(i);
    a.update();
    a.display2();
    countBug+=a.lives;
  }
  if (countBug==0) {
    endRecord();
    recordPdf = false;
    println("PDF file saved");
    noLoop();
  }
}

float average(float a, float b) {
  //float c = (a+b)/2;
  return ((a+b)/2);
}

void keyPressed() {
  if (key == 'i') tr.save("images/bugs_"+ nf(frameCount, 4) +".png");
  if (key == 'p') recordPdf = true;
}

