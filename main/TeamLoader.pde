class Team {
  String teamId;
  String name;
  String abbr;
  PImage logo;
  int gamePlayCount;
  int winCount;
  float winPercent;
  float fieldGoal;
  float threePtFieldGoal;
  float freeThrow;
  float rebounce;
  float turnover;

  Team(String teamId, String name, String abbr) {
    this.teamId = teamId;
    this.name = name;
    this.abbr = abbr;
    JSONObject src = loadJSONObject("../data/teams/" + teamId + ".json");
    JSONArray info = src.getJSONArray("resultSets")
                        .getJSONObject(0)
                        .getJSONArray("rowSet")
                        .getJSONArray(0);
    this.gamePlayCount = info.getInt(2);
    this.winCount = info.getInt(3);
    this.winPercent = info.getFloat(5);
    this.fieldGoal = info.getFloat(7);
    this.threePtFieldGoal = info.getFloat(10);
    this.freeThrow = info.getFloat(13);
    this.rebounce = info.getFloat(18);
    this.turnover = info.getFloat(20);
    this.logo = loadImage("../data/logos/" + abbr + "_logo.png");
  }
}

class TeamLoader {
  HashMap<String, Team> teams = new HashMap<String, Team>();

  TeamLoader() {
    Table t = loadTable("../data/team.csv", "header");
    for (TableRow row : t.rows()) {
      teams.putIfAbsent(row.getString(0),
                        new Team(row.getString("teamid"),
                                 row.getString("name"),
                                 row.getString("abbreviation")));
    }
  }

  public Team getTeam(String teamId) {
    return teams.get(teamId);
  }
}
