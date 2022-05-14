import java.util.Collection;
import java.util.Set;

class Player {
  String playerId;
  String name;
  int jerseyNumber;
  String position;
  String teamId;
  PImage img;
  String bestGame = null;

  Player(String playerId) {
    this.playerId = playerId;
    TableRow row = playerLoader.getPlayerRow(playerId);
    this.name = row.getString("firstname") + ", " + row.getString("lastname");
    this.jerseyNumber = row.getInt("jerseynumber");
    this.position = row.getString("position");
    this.teamId = row.getString("teamid");
    this.img = loadImage("http://stats.nba.com/media/players/700/" + playerId + ".png?interpolation=lanczos-none&resize=*:100px");
    JSONObject src = loadJSONObject("../data/careerhigh/" + playerId + ".json");
    JSONArray info = src.getJSONArray("resultSets")
                        .getJSONObject(5)
                        .getJSONArray("rowSet");
    for (int i = 0; i < info.size(); ++i) {
      String gameId = Integer.toString(info.getJSONArray(0).getInt(2) + 20000000);
      if (gameLoader.getGame(gameId) != null) {
        this.bestGame = gameId;
        println(gameId);
        break;
      }
    }
  }
}

class TeamPlayers {
  HashMap<String, Player> allPlayers = new HashMap<String, Player>(30);
  ArrayList<Player> active = new ArrayList<Player>(5);

  public void updateActivePlayers(ArrayList<String> activePlayerIds) {
    active.clear();
    for (String pid : activePlayerIds) {
      Player p = allPlayers.get(pid);
      if (p == null) {
        p = new Player(pid);
        allPlayers.putIfAbsent(pid, p);
      }
      active.add(p);
    }
  }

  public Collection<Player> getActivePlayers() {
    return active;
  }

  public Player getActivePlayer(int i) {
    return active.get(i);
  }
}
