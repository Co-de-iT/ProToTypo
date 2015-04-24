// the Stick class contains a line and stores also info on color and thickness

class Stick {

  RPoint a, b;
  color col;
  float weight;

  Stick(RPoint _a, RPoint _b, color _col, float _weight) {
    a =_a;
    b= _b;
    col = _col;
    weight = _weight;
  }

  void display() {
    stroke(col);
    strokeWeight(weight);
    line(a.x, a.y, b.x, b.y);
  }
}

