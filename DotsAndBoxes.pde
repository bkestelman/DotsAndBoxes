import java.util.Collections;

public static final int WIN_W = 250;
public static final int WIN_H = 250;
public static final int BOX_W = 250;
public static final int BOX_H = 250;

static final int N = 4; //number of dots
static float L_best = 1;

public static ArrayList<Dot> dots = new ArrayList<Dot>();
public static ArrayList<Dot> dotsX = new ArrayList<Dot>(); //dots sorted by their x coor
public static ArrayList<Dot> dotsY = new ArrayList<Dot>(); //dots sorted by their y coor

public static int cycle = 0;
public static int bestCycle = 0;
public static int MAX_TRACKING_CYCLE = 500;

public static boolean DISABLE_TRACKS = true;

void setup() {
  size(250, 250);
  smooth();
  
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
  
  float L = 0;
  for(int i = 0; i < N; i++) {
    stroke(0);
    fill(0);
    dots.get(i).display();
    if(dots.get(i).largest > L) L = dots.get(i).largest;
    //System.out.println("dotsX.get(" + i + ").vx: " + dotsX.get(i).vx);
    //System.out.println("dotsX.get(" + i + ").vy: " + dotsX.get(i).vy);
    //System.out.println("dotsX.get(" + i + ").x: " + dotsX.get(i).x);
    //System.out.println("dotsX.get(" + i + ").y: " + dotsX.get(i).y);
    dots.get(i).move();
  }
  if(L/ (BOX_W*BOX_H) < L_best) {
      L_best = L/ (BOX_W*BOX_H);
      if(cycle < MAX_TRACKING_CYCLE && !DISABLE_TRACKS) bestCycle = cycle;
    }
    System.out.println("L_best: " + L_best);
    System.out.println("L: " + L / (BOX_W*BOX_H));
    System.out.println("Best cycle:");
    for(int j = 0; j < N; j++) {
      System.out.print("Dot[" + j + "] (bestX,bestY): (" + dots.get(j).bestX() + "," + dots.get(j).bestY() + ")\t");
    }
    System.out.println("");
  cycle++;
}