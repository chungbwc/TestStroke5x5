// Using 5 x 5 grids of stroke direction
import java.util.Timer;
import java.io.FilenameFilter;
import java.io.File;
import java.util.Arrays;

boolean write;
ChinChar chr;
Schedule task;
Timer timer;
Encode enc;
Database db;
int half;
PVector offset1;
PVector offset2;
float scaling;
Drawing dw;

void setup() {
  size(1200, 600);
  background(0);
  enc = new Encode();
  db = new Database();
  dw = new Drawing();
  write = false;
  half = width/2;
  offset1 = new PVector(half, 0);
  offset2 = new PVector(20, 20);
  scaling = 560;
}

void draw() {
  background(0);
  pushStyle();
  noStroke();
  fill(255);
  rect(half, 0, half, height);
  noFill();
  stroke(50);
  rect(offset2.x, offset2.y, scaling, scaling);
  popStyle();
  if (chr == null) 
    return;
  chr.drawChar();
  chr.drawNorm(offset2, scaling);
  dw.drawChar(offset1, half);
}

void mousePressed() {
  if (mouseX > half) 
    return;
  if (timer != null) 
    timer.cancel();
  timer = new Timer();
  if (!write) {
    write = true;
    chr = new ChinChar();
  }
  chr.addStroke();
}

void mouseReleased() {
  timer.schedule(new Schedule(this), 3000);
}

void mouseDragged() {
  if (mouseX > half) 
    return;
  PVector t = new PVector(mouseX, mouseY);
  chr.addPoint(t);
}

void message() {
  dw.clear();
  write = false;
  enc.procChar(chr.normCopy());
  enc.prepareData();
  //  println("Input character ...");
  //  printArray(enc.getFeatures());
  float val = db.predict(enc.getFeatures());
  dw.setFile((int) val);
  println("Match result " + val);
}

void keyPressed() {
  if (keyCode == ENTER || keyCode == RETURN) {
    saveFrame("images/screen####.png");
  }
}