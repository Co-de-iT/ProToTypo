/*

 P5 ws RUFA
 
 tutor: Alessio Erioli - Co-de-iT
 
 font to pdf - visualize a random font and saves on request a pdf file
 
 key map:
 
 space bar - new random font
 p - save .pdf file
 
 
 */

import processing.pdf.*;

PFont font;
String[] fontList;
float xF, yF;
boolean savePDF = false;
int i =0;

void setup() {
  size(800, 300);
  smooth();

  // puts list of fonts in an array of strings
  fontList = PFont.list();
  // println(fontList); // prints font list

  xF = width*0.5;
  yF = height*0.5;

  i = int(random(fontList.length-1)); // fontList.length gives the number of elements in fontList

  font = createFont(fontList[i], 80);
  textFont(font);
  textSize(50);
  textAlign(CENTER, CENTER);
}

void draw() {
  background(230);

  if (savePDF) { 
    beginRecord(PDF, fontList[i] + ".pdf");
    textFont(font);
    textSize(50);
    textAlign(CENTER, CENTER);
  }
  stroke(90);
  strokeWeight(0.5);
  line(xF, 0, xF, height);
  line(0, yF, width, yF);
  fill(0);
  text(fontList[i], xF, yF); // the name of the font is used as text to display
  if (savePDF) {
    endRecord();
    savePDF = false;
    println("PDF file saved");
  }
}

void keyPressed() {
  if (key == 'p') savePDF = true;
  if (key == ' ') {
    i = int(random(fontList.length-1)); // fontList.length gives the number of elements in fontList
    font = createFont(fontList[i], 80);
    textFont(font);
  }
}

