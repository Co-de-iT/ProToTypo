/*

 P5 ws RUFA
 
 tutor: Alessio Erioli - Co-de-iT
 
 generative text using the bug class previously created - saves transparent png
 
 key map:
 
 i - save transparent background .png
 r - start recording video frames (use Tools > Movie Maker to make video form frames)
 
 Method
 
 To constrain bugs in text, we use an alternate PGraphics pg where we draw text in black on
 white background. Then we check if the bug is in a position where pixels on pg are black
 (inside) or white (outside). Drawing is performed on another PGraphics to allow saving as
 transparent background png
 
 */


import toxi.geom.*; // importa la libreria Toxi

Bug a, b; // dichiarazione di un oggetto della classe Bug
// tipo di dati   nome
//          |     |
ArrayList <Bug> bugs; // dichiarazione ArrayList
PGraphics tr, pg;
String text = "RUFA";
PFont font;

int nBugs = 100; // number of bugs
float d;
boolean record = false; // set to true to record video from the beginning

void setup() {
  size(1400, 700); // dimensione del canvas
   //size(displayWidth, displayHeight); // full screen cmd+shift+R
  smooth();
  font = createFont("OpenSans-Bold", 80);

  // pg è dove scriveremo il testo
  pg = createGraphics(width, height, JAVA2D);
  pg.beginDraw();
  pg.textFont(font);
  pg.textSize(500);
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
    a = new Bug(random(5, 10), random(0.01, 0.05), 
    color(0, 0, random(255)), color(255));
    bugs.add(a);
  }

}

void draw() {
  image(tr, 0, 0);
  tr.beginDraw();
  for (int i=0; i<bugs.size (); i++) {
    a = bugs.get(i);
    a.update();
    a.display(tr);
  }
  tr.endDraw();
  
  if (record) saveFrame("video/video_####.jpg");
}


void keyPressed() {
  if (key == 'i') tr.save("images/bugs_"+ nf(frameCount, 4) +".png");
  if (key == 'r') record = !record;
}

