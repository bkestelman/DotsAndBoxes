import java.util.Collections;

public static final int WIN_W = 250;
public static final int WIN_H = 250;
public static final int BOX_W = 250;
public static final int BOX_H = 250;

static final int N = 2; //number of dots

public static ArrayList<Dot> dots = new ArrayList<Dot>();
public static ArrayList<Dot> dotsX = new ArrayList<Dot>(); //dots sorted by their x coor
public static ArrayList<Dot> dotsY = new ArrayList<Dot>(); //dots sorted by their y coor

void setup() {
  size(250, 250);
  
  for(int i = 0; i < N; i++) {
    Dot d = new Dot((float)Math.random() * BOX_W, (float)Math.random() * BOX_H, i);
    dots.add(d);
    dotsX.add(d);
    dotsY.add(d);
  }
}

void draw() {
  background(255);
  Collections.sort(dotsX, new xComparator());
  Collections.sort(dotsY, new yComparator());
  
  for(int i = 0; i < N; i++) {
    stroke(0);
    fill(0);
    dots.get(i).display();
  }
}