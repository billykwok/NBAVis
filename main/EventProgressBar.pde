public class EventProgressBar {
  float progress = 0;
  int time = 0;

  public void draw(float progressRatio) {
    progress = Math.min(width, width * progressRatio);
    noStroke();
    fill(72);
    rect(0, 80, width, 8);
    fill(255, 34, 81);
    rect(0, 80, progress, 8);
    ellipseMode(CENTER);
    fill(240);
    stroke(1);
    ellipse(progress, 84, 15, 15);
  }
}