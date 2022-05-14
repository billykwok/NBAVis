class ScoreTrend {
  float x = 0;
  float y = 0;
  float width = 640;
  float height = 480;

  ScoreTrend(int x, int y, int width, int height) {
    this.x = x;
    this.y = y;
    this.width = width - 20;
    this.height = height;
  }

  public void draw(ArrayList<ScoreMoment> momentsA,
                   ArrayList<ScoreMoment> momentsB) {
    pushMatrix();
    translate(x + 10, y);

    strokeWeight(1);
    stroke(236);
    for (int k = 10; k <= 78; k += 16) line(0, k, width, k);

    // Render line
    this.drawLine(momentsA, TEAM_A_COLOR);
    this.drawLine(momentsB, TEAM_B_COLOR);

    // Render current interval highlighter
    fill(MARKER_COLOR, 128);
    noStroke();
    rect(width * (eventId - 1) / eventCount, 0, 10, height);

    // Score
    textSize(24);
    fill(100);
    int i = Math.round((float) (eventId - 1) * momentsA.size() / (eventCount + 2));
    if (i > momentsA.size() - 1) i = momentsA.size() - 1;
    int scoreA = momentsA.get(i).score;

    int j = Math.round((float) (eventId - 1) * momentsB.size() / (eventCount + 2));
    if (j > momentsB.size() - 1) j = momentsB.size() - 1;
    int scoreB = momentsB.get(j).score;

    textAlign(RIGHT);
    fill(TEAM_A_COLOR);
    text(scoreA, 40, 30);
    textAlign(CENTER);
    fill(100);
    text(" - ", 50, 30);
    textAlign(LEFT);
    fill(TEAM_B_COLOR);
    text(scoreB, 60, 30);

    popMatrix();
  }

  private void drawLine(ArrayList<ScoreMoment> moments, color c) {
    noFill();
    strokeWeight(3);
    stroke(c);
    beginShape();
    for (ScoreMoment sm : moments) {
      vertex(sm.time * width / 2880, 75 - sm.score * 80 / 150);
    }
    endShape();

    fill(255);
    strokeWeight(1.5);
    for (ScoreMoment sm : moments) {
      ellipse(sm.time * width / 2880, 75 - sm.score * 80 / 150, 5, 5);
    }
  }
}
