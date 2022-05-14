class PlayerInfoPanel {
  HashMap<Integer, Player> playersWithBestGame = new HashMap<Integer, Player>(10);
  String hoveredBestGame;

  public void draw() {
    image(teamLoader.getTeam(teamIdA).logo, 740, 250, 80, 80);
    image(teamLoader.getTeam(teamIdB).logo, 740, 660, 80, 80);

    textAlign(LEFT, CENTER);
    int i = 0;
    for (Player p : playersA.getActivePlayers()) {
      image(p.img, 860, 90 + 70 * i);
      text(p.name + " (" + p.jerseyNumber + ")", 940, 130 + 70 * i);
      text("Position: " + p.position, 940, 160 + 70 * i);
      if (p.bestGame != null) {
        playersWithBestGame.putIfAbsent(150 + 70 * i, p);
        fill(p.bestGame.equals(hoveredBestGame) ? color(252, 142, 27) : 220);
        rect(1070, 150 + 70 * i, 200, 30);
        fill(0);
        text("View Best Game", 1080, 160 + 70 * i);
      }
      ++i;
    }

    int j = 0;
    for (Player p : playersB.getActivePlayers()) {
      image(p.img, 860, 500 + 70 * j);
      text(p.name + " (" + p.jerseyNumber + ")", 940, 540 + 70 * j);
      text("Position: " + p.position, 940, 570 + 70 * j);
      if (p.bestGame != null) {
        playersWithBestGame.putIfAbsent(560 + 70 * j, p);
        fill(p.bestGame.equals(hoveredBestGame) ? color(252, 142, 27) : 220);
        rect(1070, 560 + 70 * j, 200, 30);
        fill(0);
        text("View Best Game", 1080, 570 + 70 * j);
      }
      ++j;
    }
  }

  public void onMouseMoved() {
    if (mouseX > 1070 && mouseX <= 1270) {
      for (Integer pos : playersWithBestGame.keySet()) {
        if (mouseY >= pos && mouseY < pos + 70) {
          hoveredBestGame = playersWithBestGame.get(pos).bestGame;
          cursor(HAND);
        }
      }
    }
  }

  public void onMousePressed() {
    if (mouseX > 1070 && mouseX <= 1270) {
      Player selectedPlayer = null;
      for (Integer pos : playersWithBestGame.keySet()) {
        if (mouseY >= pos && mouseY < pos + 70) {
          selectedPlayer = playersWithBestGame.get(pos);
          Game g = gameLoader.getGame(selectedPlayer.bestGame);
          gameId = g.gameId;
          teamIdA = g.homeTeamId;
          teamIdB = g.visitorTeamId;
          eventLoader.setGameId(gameId);
          eventId = eventLoader.getEventIndex();
          eventCount = gameFileCountMap.getGameFileCount(gameId);
          playByPlayLoader.setGame(gameId);
          renderClock.reset();
        }
      }
    }
  }
}
