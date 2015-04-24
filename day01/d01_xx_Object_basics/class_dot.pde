// this is how you define a class

class Dot{ // this is how you name a class - by convention the name's first letter is capital
  
  // fields
  Vec3D loc;
  color col;
  
  // constructor
  Dot(Vec3D _loc){
  // 
  col = color(255,0,0); // assign a predefined value
  loc = _loc;             // assign a value from outside
  
  }
  
  // a basic behavior or method: display
  void display(){
    point(loc.x, loc.y);
  }
  
}
