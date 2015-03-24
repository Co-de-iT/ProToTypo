
import processing.pdf.*;

PFont font;
float xF, yF;
boolean savePDF = false;

void setup() {
  size(700, 400);
  smooth();
  xF = width*0.5;
  yF = height*0.5;
  font = createFont("Optima-Italic-48", 80);
  textFont(font);
  //textSize(30);
  textAlign(CENTER, CENTER);
}

void draw() {
  background(220);
  if (savePDF){ 
    beginRecord(PDF,"test.pdf");
    textFont(font);
    textSize(30);
   textAlign(CENTER, CENTER);
  }
  fill(0);
  line(xF,0,xF,height);
  line(0,yF,width, yF);
  text("P5 ws RUFA", xF, yF);
  if (savePDF){
  endRecord();
  savePDF = false;
  println("PDF file saved");
  }
}

void keyPressed(){
  if (key == 'p') savePDF = true;
}
