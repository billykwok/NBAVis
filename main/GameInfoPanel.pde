class GameInfoPanel {
  GameInfoPanel() {}

  public void draw(ArrayList<ScoreMoment> momentsA,
                   ArrayList<ScoreMoment> momentsB) {
    textSize(64);
    int pos = 390;
    int i = Math.round((float) (eventId - 1) * momentsA.size() / (eventCount + 2));
    if (i > momentsA.size() - 1) i = momentsA.size() - 1;
    int scoreA = momentsA.get(i).score;
    int j = Math.round((float) (eventId - 1) * momentsB.size() / (eventCount + 2));
    if (j > momentsB.size() - 1) j = momentsB.size() - 1;
    int scoreB = momentsB.get(j).score;
    textAlign(RIGHT);
    fill(TEAM_A_COLOR);
    text(scoreA, pos - 10, 560);
    textAlign(CENTER);
    fill(100);
    text(" - ", pos, 560);
    textAlign(LEFT);
    fill(TEAM_B_COLOR);
    text(scoreB, pos + 10, 560);

    imageMode(CENTER);
    Team teamA = teamLoader.getTeam(teamIdA);
    Team teamB = teamLoader.getTeam(teamIdB);
    PImage logoA = teamA.logo;
    logoA.resize(120, 120);
    image(logoA, 220, 540);
    PImage logoB = teamB.logo;
    logoB.resize(120, 120);
    image(logoB, 570, 540);
    imageMode(CORNER);

    fill(0);
    textSize(18);
    textAlign(RIGHT);
    text("Total Game Play", 200, 640);
    textAlign(CENTER);
    text(Float.toString(teamA.gamePlayCount), 280, 640);
    text(Float.toString(teamB.gamePlayCount), 500, 640);

    textAlign(RIGHT);
    text("Field Goals", 200, 670);
    textAlign(CENTER);
    text(Float.toString(teamA.fieldGoal), 280, 670);
    text(Float.toString(teamB.fieldGoal), 500, 670);

    textAlign(RIGHT);
    text("3 Point Field Goals", 200, 700);
    textAlign(CENTER);
    text(Float.toString(teamA.threePtFieldGoal), 280, 700);
    text(Float.toString(teamB.threePtFieldGoal), 500, 700);

    textAlign(RIGHT);
    text("Free Throws", 200, 730);
    textAlign(CENTER);
    text(Float.toString(teamA.freeThrow), 280, 730);
    text(Float.toString(teamB.freeThrow), 500, 730);

    textAlign(RIGHT);
    text("Rebounces", 200, 760);
    textAlign(CENTER);
    text(Float.toString(teamA.rebounce), 280, 760);
    text(Float.toString(teamB.rebounce), 500, 760);

    textAlign(RIGHT);
    text("Turnovers", 200, 790);
    textAlign(CENTER);
    text(Float.toString(teamA.turnover), 280, 790);
    text(Float.toString(teamB.turnover), 500, 790);
  }
}
