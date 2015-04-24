/*

P5 ws RUFA - class_aclass

tutor: Alessio Erioli - Co-de-iT

let's define a class and a few methods (behaviors)

*/


import toxi.geom.*; // importa la libreria Toxi

/*
primitives:
 float < floating point numbers - numeri in virgola mobile
 int < integer numbers - numeri interi
 boolean < boolean values - valori booleani (true o false)
 
 */


// dichiarazione di un oggetto della classe Bug
Bug a; // declare an object of the class Bug

PImage logo; // PImage object that will contain RUFA logo

void setup() {
  size(400, 700, P2D);
  smooth(8);
  a = new Bug(width * 0.5, height * 0.5);
  logo = loadImage("RUFA_logo_80.png");
  background(240);
}

void draw() {
  a.update();
  a.display();
   image(logo, width-100, height-100);
}

