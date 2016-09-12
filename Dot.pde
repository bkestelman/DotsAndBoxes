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
  
  public Dot(float x, float y, int id) {
    this.id = id;
    this.x = x;
    this.y = y;
    vx = vy = ax = ay = 0; 
  }

  public void display() {
    ellipse(x, y, 5, 5);
    vx = vy = 0;
    displayBoxes();
  }
  
  public void displayBoxes() {
    stroke(0,100,100);
    fill(0,100,100, 50);
    rectMode(CORNERS);
    /*for(Direction dir : Direction.values()) {
      Box box = new Box(x 
    }*/
    
    //LEFT
    float prevUp = 0;
    float prevDown = BOX_H;
    ListIterator<Dot> li = dotsX.listIterator(dotsX.size());
    while(li.hasPrevious()) {
      Dot dot = li.previous();
      if(dot.x < x && dot.y < prevDown && dot.y > prevUp) {
        rect(dot.x, prevUp, x, prevDown);
        vx -= (x - dot.x) * (prevDown - prevUp);
        if(dot.y < y) prevUp = dot.y;
        else prevDown = dot.y;
      }
    }
    rect(0, prevUp, x, prevDown);
    vx -= x * (prevDown - prevUp);
    prevUp = 0;
    prevDown = BOX_H;
    //RIGHT
    li = dotsX.listIterator();
    while(li.hasNext()) {
      Dot dot = li.next();
      if(dot.x > x && dot.y < prevDown && dot.y > prevUp) {
        rect(x, prevUp, dot.x, prevDown);
        vx += (dot.x - x) * (prevDown - prevUp);
        if(dot.y < y) prevUp = dot.y;
        else prevDown = dot.y;
      }
    }
    rect(x, prevUp, BOX_W, prevDown);
    vx += (BOX_W - x) * (prevDown - prevUp);
    //UP
    float prevLeft = 0;
    float prevRight = BOX_W;
    li = dotsY.listIterator(dotsY.size());
    while(li.hasPrevious()) {
      Dot dot = li.previous();
      if(dot.y < y && dot.x < prevRight && dot.x > prevLeft) {
        rect(prevLeft, dot.y, prevRight, y);
        vy -= (y - dot.y) * (prevRight - prevLeft); 
        if(dot.x < x) prevLeft = dot.x;
        else prevRight = dot.x;
      }
    }
    rect(prevLeft, 0, prevRight, y);
    vy -= y * (prevRight - prevLeft);
    prevLeft = 0;
    prevRight = BOX_W;
    //DOWN
    li = dotsY.listIterator();
    while(li.hasNext()) {
      Dot dot = li.next();
      if(dot.y > y && dot.x < prevRight && dot.x > prevLeft) {
        rect(prevLeft, y, prevRight, dot.y);
        vy += (dot.y - y) * (prevRight - prevLeft);
        if(dot.x < x) prevLeft = dot.x;
        else prevRight = dot.x;
      }
    }
    rect(prevLeft, BOX_H, prevRight, y);
    vy += (BOX_H - y) * (prevRight - prevLeft);
    vx /= BOX_W * BOX_H;
    vy /= BOX_W * BOX_H;
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