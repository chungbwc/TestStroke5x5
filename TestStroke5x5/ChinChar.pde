public class ChinChar {
  final int MAX_STK = 100;

  ArrayList<Stroke> strokes;
  PVector mx;
  PVector mn;

  public ChinChar() {
    strokes = new ArrayList<Stroke>();
    mx = new PVector(Float.MIN_VALUE, Float.MIN_VALUE);
    mn = new PVector(Float.MAX_VALUE, Float.MAX_VALUE);
  }

  void adjustMinMax(PVector pn, PVector px) {
    if (pn.x < mn.x) {
      mn.x = pn.x;
    }
    if (pn.y < mn.y) {
      mn.y = pn.y;
    }
    if (px.x > mx.x) {
      mx.x = px.x;
    }
    if (px.y > mx.y) {
      mx.y = px.y;
    }
    for (Stroke s : strokes) {
      s.adjustMinMax(mn, mx);
    }
  }

  void addStroke() {
    if (strokes.size() > MAX_STK) 
      return;
    strokes.add(new Stroke(this));
  }

  void addPoint(PVector p) {
    if (strokes.size()==0) 
      return;
    strokes.get(strokes.size()-1).addPoint(p);
  }

  void drawChar() {
    for (Stroke s : strokes) {
      s.drawPoints();
    }
  }

  void drawNorm(PVector os, float sc) {
    for (Stroke s : strokes) {
      s.drawNorm(os, sc);
    }
  }

  void clear() {
    for (Stroke s : strokes) {
      s.clear();
    }
    strokes.clear();
  }

  ChinChar normCopy() {
    ChinChar tmp = new ChinChar();
    for (Stroke s : strokes) {
      Stroke ss = new Stroke(tmp);
      for (int i=0; i<s.points.size(); i++) {
        ss.addPoint(s.norm(s.points.get(i)));
      }
      tmp.strokes.add(ss);
    }
    return tmp;
  }
}