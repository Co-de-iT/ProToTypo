Vec2D getPosition(color col) {
  Vec2D loc = new Vec2D(random(width), random(height));
  while ( !inside (p, loc, col)) 
    loc = new Vec2D(random(width), random(height));
  return loc;
}


Vec2D getRange(float minBri, float maxBri) {
  Vec2D loc = new Vec2D(random(width), random(height));
  while ( !insideImg (p, loc, minBri, maxBri)) 
    loc = new Vec2D(random(width), random(height));
  return loc;
}

Vec2D getDensity(float minDens, float maxDens, float deg) {
  Vec2D loc = new Vec2D(random(width), random(height));
  while ( random(1.0) > pow(map(brightness(p.get(int(loc.x), int(loc.y))), 0.0, 255.0, minDens, maxDens),deg)) 
    loc = new Vec2D(random(width), random(height));
  return loc;
}

boolean inside(PGraphics p, Vec2D loc, color c) {
  return p.get(int(loc.x), int(loc.y)) == c;
}

boolean insideImg(PGraphics p, Vec2D loc, float minBri, float maxBri) {
  float bri = brightness(p.get(int(loc.x), int(loc.y)));
  return (bri > minBri && bri < maxBri);
}

