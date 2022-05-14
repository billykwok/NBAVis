public class BtnPlay {
  float x, y, length;

  BtnPlay(float x, float y, float length) {
    this.x = x;
    this.y = y;
    this.length = length;
  }

  public void draw(boolean isPlaying) {
    float padding = 25;
    noStroke();
    fill(200);
    rect(x, y, length, length);
    pushMatrix();
    translate(x, y);
    fill(100);
    if (isPlaying) {
      float temp = (length - padding * 2) / 3;
      rect(padding, padding, temp, length - padding * 2);
      rect(padding + temp * 2, padding, temp, length - padding * 2);
    } else {
      triangle(padding, padding, length - padding, length / 2, padding, length - padding);
    }
    popMatrix();
  }
}