
class Bug {

  // fields
  Vec2D loc, speed;
  float diam, life, lifeRate;
  color col, col2;

  // constructor(s)

  /*
  Uso di più costruttori
   
   una istanza di una classe (oggetto) può essere costruita in più modi
   Ad esempio, quando definiamo un Vec3D di dimensioni 0 lo si può 
   costruire così:
   Vec3D v = new Vec3D();
   oppure così:
   Vec3D v = new Vec3D(0,0,0);
   
   il vettore creato è lo stesso, ma i modi sono diversi. In questo caso esistono
   più costruttori all'interno della stessa classe. Convenzionalmente si ha un
   costruttore 'generale', ovvero quello che consente di definire il massimo numero
   di parametri dall'esterno, poi tutti i costruttori alternativi richiamano il
   generale.
   */

  Bug(float x, float y, float _diam, float _lifeRate, 
  color _col, color _col2) {

    loc = new Vec2D(x, y);
    speed = new Vec2D(3, 0);
    diam = _diam;
    col = _col;
    col2 = _col2;
    life=1;
    lifeRate = _lifeRate;
  }


  Bug(Vec2D _loc, float _diam, float _lifeRate, 
  color _col, color _col2) {

    // richiamiamo il costruttore più generale (qui sopra)
    this (_loc.x, _loc.y, _diam, _lifeRate, _col, _col2);
  }

  // methods

  void update() {
    if (frameCount % 1 == 0) speed.rotate(random(-QUARTER_PI, QUARTER_PI));
    loc.addSelf(speed);
    life -= lifeRate;  //life = life-lifeRate;
    respawn();
  }

  void respawn() {
    /*
    boolean operators
     && and
     || or
     !  not
     */
    if (life <=0 || bounds()) {
      life = 1;
      loc = new Vec2D(width*0.5, height*0.5);
    }
  }

  boolean bounds() {
    return (loc.x + diam*life *0.5 < 0 || loc.x - diam*life * 0.5 > width ||
      loc.y + diam*life * 0.5 < 0 || loc.y - diam*life * 0.5 > height);
  }

  void display() {
    //noStroke();
    fill(lerpColor(col, col2, 1-life));
    ellipse(loc.x, loc.y, diam*life, diam*life);
  }
}

