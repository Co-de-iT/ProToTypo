class JitterBug {

  // fields - class properties
  Vec2D loc, speed;
  float diam;
  color col;

  // constructor(s) - how to build class instances
  JitterBug (Vec2D _loc, float _diam, float _speed, color _col) {
    loc = _loc;
    diam = _diam;
    speed = new Vec2D(_speed,0);
    col = _col;
  }

  // si possono costruire costruttori a cascata, in cui uno solo contiene
  // tutti i parametri definiti dall'utente e gli altri fanno
  // riferimento a quello. Nel nostro caso è quello qui sopra.
  // in classe abbiamo dovuto fare il costruttore random così:
  
  /*JitterBug() {
   loc = new PVector(random(width), random(height));
   diam = random(2, 20);
   speed = random(1, 8);
   col = color(random(255), random(255), random(255));
   }*/

  // per chiamare correttamente i costruttori a cascata, tutti gli altri
  // costruttori devono chiamare quello principale con "this" al posto del 
  // nome del costruttore. Vedi qui sotto.
  // qui c'è la spiegazione di come chiamare i costruttori a cascata:
  // http://forum.processing.org/two/discussion/463/issue-calling-class-constructor/p1
  // per Java: http://stackoverflow.com/questions/285177/how-do-i-call-one-constructor-from-another-in-java/16080312
  JitterBug() {
    this(new Vec2D(random(width), random(height)),
    random(2, 20), 
    random(1, 8), 
    color(random(255), random(255), random(255)));
  }

  // methods

  void update() {
    randoMove();
    respawn();
    //display();
  }


  void display(PGraphics p) {
    p.fill(col);
    p.ellipse(loc.x, loc.y, 2+sin(frameCount*0.02)*diam, 2+sin(frameCount*0.02)*diam);
  }

  void randoMove() {
    speed.rotate(random(-QUARTER_PI,QUARTER_PI));
    loc.addSelf(speed);
  }

  void respawn() {
    if (loc.x<0 || loc.x>width || loc.y<0 || loc.y> height)
      loc = new Vec2D(random(width), random(height));
  }
}
