/*

 P5 ws RUFA
 
 tutor: Alessio Erioli - Co-de-iT
 
 generative text using the bug class previously created - saves pdf when bugs are all 'dead'
 
 key map:
 
 i - save transparent background .png
 p - save pdf file
 
 Method
 
 To constrain bugs in text, we use an alternate PGraphics pg where we draw text in black on
 white background. Then we check if the bug is in a position where pixels on pg are black
 (inside) or white (outside).
 Bugs have a liferate and a max number of 'lives' (times they can respawn). Everytime 
 a bug's life reaches 0 it is respawned (life restored, n. of lives decreases).
 When all lives have reached 0 a pdf file is saved.
 
 */
 
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
    a = new Bug(random(5, 10), random(0.02, 0.01), 
    color(0, 0, random(255)), color(255));
    bugs.add(a);
  }

  beginRecord(PDF, "PDF/test_4.pdf");
  strokeWeight(0.5);
}

void draw() {

  countBug=0;
  
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

void keyPressed() {
  if (key == 'i') tr.save("images/bugs_"+ nf(frameCount, 4) +".png");

}

