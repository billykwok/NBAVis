class Game {
  String gameId;
  String date;
  String homeTeamId;
  String visitorTeamId;

  Game(String gameId, String date, String homeTeamId, String visitorTeamId) {
    this.gameId = gameId;
    this.date = date;
    this.homeTeamId = homeTeamId;
    this.visitorTeamId = visitorTeamId;
  }
}

class GameLoader {
  Table gameTable;

  GameLoader() {
    gameTable = loadTable("../data/games.csv", "header");
  }

  public Game getGame(String gameId) {
    TableRow row = gameTable.findRow(gameId, "gameid");
    if (row != null) {
      return new Game("00" + row.getString("gameid"),
                      row.getString("gamedate"),
                      row.getString("hometeamid"),
                      row.getString("visitorteamid"));
    }
    return null;
  }

  public ArrayList<Game> getGamesRowsByTeams(String teamId1, String teamId2) {
    ArrayList<Game> games = new ArrayList<Game>();

    Table filtered1 = new Table(gameTable.findRows(teamId1, "hometeamid"));
    for (TableRow row : filtered1.findRows(teamId2, "visitorteamid")) {
      games.add(new Game("00" + row.getString("gameid"),
                         row.getString("gamedate"),
                         row.getString("hometeamid"),
                         row.getString("visitorteamid")));
    }

    Table filtered2 = new Table(gameTable.findRows(teamId1, "visitorteamid"));
    for (TableRow row : filtered2.findRows(teamId2, "hometeamid")) {
      games.add(new Game("00" + row.getString("gameid"),
                         row.getString("gamedate"),
                         row.getString("hometeamid"),
                         row.getString("visitorteamid")));
    }

    return games;
  }
}
