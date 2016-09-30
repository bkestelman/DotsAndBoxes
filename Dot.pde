import java.util.Comparator;
import java.util.ListIterator;

public enum Direction {
  LEFT(-1, 0), UP(0, -1), RIGHT(1, 0), DOWN(0, 1);
  
  private Direction(int x, int y) {
    xDir = x;
    yDir = y;
  }
  
  public int xDir;
  public int yDir;
}

public class xComparator implements Comparator<Dot> {
  @Override
  public int compare(Dot a, Dot b) {
    if(a.x > b.x) return 1;
    if(a.x < b.x) return -1;
    return 0;
  }
}

public class yComparator implements Comparator<Dot> {
  @Override
  public int compare(Dot a, Dot b) {
    if(a.y > b.y) return 1;
    if(a.y < b.y) return -1;
    return 0;
  }
}

public class Dot {
  float x, y, vx, vy, ax, ay; //2D position, velocity, acceleration
  int id;
  float largest = 0;
  ArrayList<Float> xTrail, yTrail;
  
  public Dot(float x, float y, int id) {
    this.id = id;
    this.x = x;
    this.y = y;
    vx = vy = ax = ay = 0; 
    xTrail = new ArrayList<Float>();
    yTrail = new ArrayList<Float>();
    xTrail.add(x);
    yTrail.add(y);
  };
  }

  public void display() {
    ellipse(x, y, 5, 5);
    vx = vy = 0;
    displayBoxes();
    if(DISABLE_TRACKS) return;
    for(int i = 0; i < xTrail.size(); i++) {
      if(i == bestCycle) {
        fill(150, 150, 0);
        ellipse(xTrail.get(i), yTrail.get(i), 10, 10);
        fill(0,100,100,50);
      }
      ellipse(xTrail.get(i), yTrail.get(i), 3, 3);
    }
    if(cycle < MAX_TRACKING_CYCLE) {
      xTrail.add(x);
      yTrail.add(y);
    }
  }
  
  public void displayBoxes() {
    stroke(0,100,100);
    fill(0,100,100, 50);
    rectMode(CORNERS);
    /*for(Direction dir : Direction.values()) {
      Box box = new Box(x 
    }*/
    
    float largestP = 0; //largest rectangle touching dot in positive direction (either coor)
    float largestN = 0; //largest rectangle touching dot in negative direction (either coor)
    float cur = 0;
    largest = 0;
    
    //LEFT
    float prevUp = 0;
    float prevDown = BOX_H;
    ListIterator<Dot> li = dotsX.listIterator(dotsX.size());
    while(li.hasPrevious()) {
      Dot dot = li.previous();
      if(dot.x < x && dot.y < prevDown && dot.y > prevUp) {
        rect(dot.x, prevUp, x, prevDown);
        cur = (x - dot.x) * (prevDown - prevUp);
        if(cur > largestN) largestN = cur;
        if(dot.y < y) prevUp = dot.y;
        else prevDown = dot.y;
      }
    }
    rect(0, prevUp, x, prevDown);
    cur = x * (prevDown - prevUp);
    if(cur > largestN) largestN = cur;
    prevUp = 0;
    prevDown = BOX_H;
    //RIGHT
    li = dotsX.listIterator();
    while(li.hasNext()) {
      Dot dot = li.next();
      if(dot.x > x && dot.y < prevDown && dot.y > prevUp) {
        rect(x, prevUp, dot.x, prevDown);
        cur = (dot.x - x) * (prevDown - prevUp);
        if(cur > largestP) largestP = cur;
        if(dot.y < y) prevUp = dot.y;
        else prevDown = dot.y;
      }
    }
    rect(x, prevUp, BOX_W, prevDown);
    cur = (BOX_W - x) * (prevDown - prevUp);
    if(cur > largestP) largestP = cur;
    if(largestP > largestN) {
      vx = largestP;
      //vx = 0.5;
    }
    else vx = -largestN;
    //else vx = -0.5;
    if(largestP > largest) largest = largestP;
    if(largestN > largest) largest = largestN;
    largestN = largestP = cur = 0;
    //UP
    float prevLeft = 0;
    float prevRight = BOX_W;
    li = dotsY.listIterator(dotsY.size());
    while(li.hasPrevious()) {
      Dot dot = li.previous();
      if(dot.y < y && dot.x < prevRight && dot.x > prevLeft) {
        rect(prevLeft, dot.y, prevRight, y);
        cur = (y - dot.y) * (prevRight - prevLeft);
        if(cur > largestN) largestN = cur;
        if(dot.x < x) prevLeft = dot.x;
        else prevRight = dot.x;
      }
    }
    rect(prevLeft, 0, prevRight, y);
    cur = y * (prevRight - prevLeft);
    if(cur > largestN) largestN = cur;
    prevLeft = 0;
    prevRight = BOX_W;
    //DOWN
    li = dotsY.listIterator();
    while(li.hasNext()) {
      Dot dot = li.next();
      if(dot.y > y && dot.x < prevRight && dot.x > prevLeft) {
        rect(prevLeft, y, prevRight, dot.y);
        cur = (dot.y - y) * (prevRight - prevLeft);
        if(cur > largestP) largestP = cur;
        if(dot.x < x) prevLeft = dot.x;
        else prevRight = dot.x;
      }
    }
    rect(prevLeft, BOX_H, prevRight, y);
    cur = (BOX_H - y) * (prevRight - prevLeft);
    if(cur > largestP) largestP = cur;
    if(largestP > largestN) {
      //vy = 0.5;
      vy = largestP;
    }
    //else vy = -0.5;
    else vy = -largestN;
    if(largestP > largest) largest = largestP;
    if(largestN > largest) largest = largestN;
    vx /= BOX_W * BOX_H;
    vy /= BOX_W * BOX_H;
  }
  
  public float bestX() {
    return xTrail.get(bestCycle);
  }
  
  public float bestY() {
    return yTrail.get(bestCycle);
  }
  
  /*public void displayNextLeftBox() {
    stroke(0,100,100);
    fill(0,100,100, 100);
    rectMode(CORNERS);
    if(dot.id != id && dot.x < x && (dot.y < prevDown || dot.y > prevUp)) {
        rect(dot.x, prevUp, x, prevDown);
        if(dot.y < y) prevUp = dot.y;
        else prevDown = dot.y;
     }
     rect(0, prevUp, x, prevDown);
  }*/
  
  public void move() {
    x += vx;
    y += vy;
  }
}