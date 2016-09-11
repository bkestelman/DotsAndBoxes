public class Dot {
  double x, y; //coor
  
  public Dot(double x, double y) {
    this.x = x;
    this.y = y;
  }
  
  public void display() {
    ellipse((float)x, (float)y, 5, 5);
  }
}