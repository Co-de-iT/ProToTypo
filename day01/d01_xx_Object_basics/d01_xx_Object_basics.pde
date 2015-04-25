/*

P5 ws RUFA

tutor: Alessio Erioli - Co-de-iT

object and classes basics

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
 
 void setup(){
   
   size(800, 450);
   logo = loadImage("RUFA_logo_80.png");
   p = new Dot (new Vec3D(width/2, height/2,0));
   
   strokeWeight(5);
 
 }
 
 void draw(){
 background(240);
 stroke(p.col);
 p.display();
 image(logo, width-100, height-100);
 
 }
