class GamePicker {
  int selected = -1;
  ArrayList<Game> gameList = new ArrayList<Game>();

  public void draw(String teamIdA, String teamIdB) {
    gameList = gameLoader.getGamesRowsByTeams(teamIdA, teamIdB);

    fill(120);
    textAlign(CENTER, CENTER);
    textSize(24);
    text("Home Team", width / 2 - 240, 120);
    text("Visitor Team", width / 2 + 240, 120);

    int i = 0;
    for (Game g : gameList) {
      fill(120);
      textSize(22);
      text(g.date, width / 2 - 360, 180 + i * 100);

      fill(selected == i ? color(252, 142, 27) : 240);
      noStroke();
      rect(width / 2 - 450, 205 + i * 100, 900, 50);

      fill(64);
      textSize(36);
      text(teamLoader.getTeam(g.homeTeamId).name, width / 2 - 240, 220 + i * 100);

      textSize(24);
      text("vs", width / 2, 220 + i * 100);
      textSize(36);
      text(teamLoader.getTeam(g.visitorTeamId).name, width / 2 + 240, 220 + i * 100);
      ++i;
    }
    textAlign(LEFT, CENTER);
  }

  public void onMouseMoved() {
    selected = (((int) mouseY - 205) / 100);
  }

  public void onMousePressed() {
    int id = ((int) mouseY - 245) / 100;
    if (id >= 0 && id < gameList.size()) {
      Game selectedGame = gameList.get(id);
      gameId = selectedGame.gameId;
      eventLoader.setGameId(gameId);
      eventId = eventLoader.getEventIndex();
      eventCount = gameFileCountMap.getGameFileCount(gameId);
      playByPlayLoader.setGame(gameId);
      renderClock.reset();
      page = 2;
    }
  }
}
