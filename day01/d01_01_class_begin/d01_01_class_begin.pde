/*

P5 ws RUFA

tutor: Alessio Erioli - Co-de-iT

first sketch - several introductory stuff, the current version draws with mouse

*/

// commento monolinea

/*
  commento
  multilinea
*/

float diam, xEl, yEl; // più variabili stesso tipo

void setup(){  // < metodo di setup - eseguito 1 volta sola
   // finestra di lavoro di 800 x 600 pixel
   // o canvas
   size(800,600);
   // size(width -> X, height - > Y); in pixels
   ellipseMode(CENTER); // disegna ellissi dal centro
   diam = 50;
   xEl = 100;
   yEl = 120;
}

void draw(){ // eseguita per sempre
  //background(128); // la cosa che pulisce
  /*
  0 < toni di grigio
  0,20 < toni di grigio, alpha (trasp 0 <> 255 opa)
  255,120,200 < R, G, B
  255,120,200, 120 < R, G, B, alpha
  */
  
  // update
  xEl = xEl+0.1;
  // diam = diam +0.1; // la cosa che cresce
  
  // display
  /*
  stroke(0); // colore dei contorni
  strokeWeight(30); // spessore dei contorni
  fill(255,110); // colore di riempimento
  point(300, 400);
  stroke(255,120,200);
  strokeWeight(50);
  point(450, 200);
  strokeWeight(10);
  */
  noStroke(); // niente contorno > noFill() niente riempimento
  fill(255,10);
  ellipse(mouseX, mouseY, diam, diam);
  stroke(0);
  strokeWeight(0.5);
  line(pmouseX, pmouseY, mouseX,mouseY);
}

// ________________ funzioni extra

void keyPressed(){ // se premo un tasto....
   // 
   if(key == 'i'){ // == operatore booleano
     saveFrame("images/drawing_####.png");
     println("immagine salvata");
   }else{
     println("hai premuto " + key );
   }
}
