public class BasketballCourt {
  float width, height = 0;
  int x, y;
  PImage img;

  BasketballCourt(int x, int y, float width, float height) {
    this.height = height;
    init(x, y, width);
  }

  BasketballCourt(int x, int y, float width) {
    init(x, y, width);
  }

  private void init(int x, int y, float width) {
    this.x = x;
    this.y = y;
    this.width = width;
    img = loadImage("../img/bg_court.png");
  }

  public void draw() {
    if (this.height != 0) {
      image(img, x, y, width, height);
    } else {
      image(img, x, y, width, width * img.height / img.width);
    }
  }

  public void addPlayer(float x, float y, color c) {
    ellipseMode(CENTER);
    fill(c);
    ellipse(x + this.x, y + this.y, 10, 10);
  }

  public void addBall(float x, float y, float z, color c) {
    ellipseMode(CENTER);
    fill(c);
    ellipse(x + this.x, y + this.y, 10, 10);
  }
}
