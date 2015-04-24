class Stick {

  Vec2D a, b;
  int count;

  Stick(Vec2D _a, Vec2D _b) {
    a=_a;
    b=_b;
    count = 0;
  }


  void display(PGraphics pg) {
    pg.pushStyle();
    pg.stroke(0);
    pg.strokeWeight(.5);
    pg.line(a.x, a.y, b.x, b.y);
    pg.popStyle();
  }
}
