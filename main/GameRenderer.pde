class GameRenderer {
  BasketballCourt basketballCourt;

  GameRenderer() {
    basketballCourt = new BasketballCourt(70, 120, 640);
  }

  public void draw(Table table) {
    basketballCourt.draw();
    ArrayList<String> curPlayerIdsA = new ArrayList<String>(5);
    ArrayList<String> curPlayerIdsB = new ArrayList<String>(7);
    for (TableRow row : table.rows()) {
      float x = map(row.getInt(3), 0, 94, 0, 640);
      float y = map(row.getInt(4), 0, 94, 0, 640);
      String teamId = row.getString(1);

      if (teamId.equals("-1")) {
        float z = map(row.getInt(5), 0, 5, 0, 100);
        basketballCourt.addBall(x, y, z, color(50));
      } else if (teamId.equals(teamIdA)) {
        curPlayerIdsA.add(row.getString(2));
        basketballCourt.addPlayer(x, y, TEAM_A_COLOR);
      } else if (teamId.equals(teamIdB)) {
        curPlayerIdsB.add(row.getString(2));
        basketballCourt.addPlayer(x, y, TEAM_B_COLOR);
      } else {
        Game g = gameLoader.getGame(gameId);
        if (g != null) {
          teamIdA = g.homeTeamId;
          teamIdB = g.visitorTeamId;
        }
      }
    }
    playersA.updateActivePlayers(curPlayerIdsA);
    playersB.updateActivePlayers(curPlayerIdsB);
  }
}