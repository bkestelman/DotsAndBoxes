static final int WIN_W = 500;
static final int WIN_H = 500;
static final int BOX_W = 250;
static final int BOX_H = 250;

static final int N = 3; //number of dots

Dot[] dots = new Dot[N];

void setup() {
  size(500, 500);
  
  for(int i = 0; i < N; i++) {
    dots[i] = new Dot(WIN_W/2 - BOX_W/2 + Math.random() * BOX_W, WIN_H/2 - BOX_H/2 + Math.random() * BOX_H);
  }
}

void draw() {
  background(255);
  stroke(0);
  fill(255);
  rectMode(CENTER);
  rect(WIN_W/2, WIN_H/2, BOX_W, BOX_H);
  
  fill(0);
  for(int i = 0; i < N; i++) {
    dots[i].display();
  }
    
}