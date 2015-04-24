/*

 class SVGImporter
 
 I wrote this class to make your life easier in dealing with SVG files through the geomerative
 library. Once you get more expert in using Processing (which I hope will happen soon) you can
 check how to use geomerative directly without this importer and maybe write your own classes.
 
 Usage:
 
 . declare the SVGImporter instance, using the proper constructor for svg or text
 . to get points in the Vec2D format use either:
 . getPtsAdaptive();          // points will be denser in curved areas
 . getPtsUniformStep(step);   // points are taken at uniform parametric step (0 <> 1)
 . getPtsUniformLength(len);  // points are evenly distributed every len segment
 
 . same logic to get tangents in the Vec2D format:
 . getTansAdaptive();          // points will be denser in curved areas
 . getTansUniformStep(step);   // points are taken at uniform parametric step (0 <> 1)
 . getTansUniformLength(len);  // points are evenly distributed every len segment
 
 . to get a specific point and/or its tangent at a given step:
 
 . getPointAt(step);
 . getTanAt(step);
 
 */

import geomerative.*;

class SVGImporter {

  PApplet p5;
  String fileName;
  RShape rShape;
  RFont font;  

  SVGImporter(PApplet p5, String fileName) {
    this.fileName = fileName;
    this.p5 = p5;
    RG.init(p5); //initialize Geomerative library
    RG.ignoreStyles(ignStyle); // if true, ignores svg styles
    rShape = RG.loadShape(fileName);
  }
  
  SVGImporter(PApplet p5, String text, String font, int fSize){
    this.font = new RFont(font, fSize);
    RG.init(p5); //initialize Geomerative library
    RG.ignoreStyles(ignStyle); // if true, ignores svg styles
    rShape = this.font.toShape(text);
  }

  void centerShape(PGraphics p, float margin, float tol1, float tol2) {
    rShape.centerIn(p, margin, tol1, tol2);
    //rShape.centerIn(p, 50, 1, 1);
  }

  PShape getShape(Vec2D[][] pts) {
    PShape p = createShape(GROUP);
    for (int i=0; i< pts.length; i++) {
      if (pts[i] != null) {
        PShape pC = createShape();
        pC.disableStyle();
        pC.beginShape();
        pC.stroke(0);
        pC.strokeWeight(.5);
        pC.noFill();

        for (int j=0; j<pts[i].length; j++) {
          pC.vertex(pts[i][j].x, pts[i][j].y);
        }
        pC.endShape(CLOSE);
        
        p.addChild(pC);
      }
    }
    return p;
  }

  Vec2D[][] getPts(RPoint[][] points) {
    Vec2D[][] pts = new Vec2D[points.length][];
    for (int i=0; i< points.length; i++) {
      if (points[i] != null) {
        pts[i] = new Vec2D[points[i].length];
        for (int j=0; j<points[i].length; j++) {
          pts[i][j] = new Vec2D(points[i][j].x, points[i][j].y); // transform Rpoint in Vec2D
        }
      }
    }
    return pts;
  }


  Vec2D[][] getPtsAdaptive() {
    RPoint[][] points;
    RG.setPolygonizer(RG.ADAPTATIVE);
    points = rShape.getPointsInPaths();
    return getPts(points);
  }

  Vec2D[][] getPtsUniformStep(float step) {
    //Vec2D[][] pts;
    RPoint[][] points;
    if ( step<0 || step > 1) {
      return null;
    } else {
      RG.setPolygonizer(RG.UNIFORMSTEP);
      RG.setPolygonizerStep(step); // sampling step must be between 0 and 1
      points = rShape.getPointsInPaths();
      return getPts(points);
    }
  }

  Vec2D[][] getPtsUniformLength(float len) {
    //Vec2D[][] pts;
    RPoint[][] points;
    RG.setPolygonizer(RG.UNIFORMLENGTH);
    RG.setPolygonizerLength(len); // sampling step is the segment length (in pixels)
    points = rShape.getPointsInPaths();
    return getPts(points);
  }

  Vec2D[][] getTansAdaptive() {
    RPoint[][] points;
    RG.setPolygonizer(RG.ADAPTATIVE);
    points = rShape.getTangentsInPaths();
    return getPts(points);
  }

  Vec2D[][] getTansUniformStep(float step) {
    //Vec2D[][] pts;
    RPoint[][] points;
    if ( step<0 || step > 1) {
      return null;
    } else {
      RG.setPolygonizer(RG.UNIFORMSTEP);
      RG.setPolygonizerStep(step); // sampling step must be between 0 and 1
      points = rShape.getTangentsInPaths();
      return getPts(points);
    }
  }

  Vec2D[][] getTansUniformLength(float len) {
    //Vec2D[][] pts;
    RPoint[][] points;
    RG.setPolygonizer(RG.UNIFORMLENGTH);
    RG.setPolygonizerLength(len); // sampling step is the segment length (in pixels)
    points = rShape.getTangentsInPaths();
    return getPts(points);
  }



  Vec2D getPointAt(float step) {
    RPoint p = rShape.getPoint(step);
    return new Vec2D(p.x, p.y);
  }

  Vec2D getTanAt(float step) {
    RPoint tg = rShape.getTangent(step);
    return new Vec2D(tg.x, tg.y);
  }
}
