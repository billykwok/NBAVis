class ScoreMoment {
  public int time;
  public int score;
  ScoreMoment(int time, int score) { this.time = time; this.score = score; }
}

class PlayByPlayLoader {
  ArrayList<ScoreMoment> momentsA = new ArrayList<ScoreMoment>();
  ArrayList<ScoreMoment> momentsB = new ArrayList<ScoreMoment>();

  PlayByPlayLoader(String gameId) { setGame(gameId); }
  public ArrayList<ScoreMoment> getScoresA() { return momentsA; }
  public ArrayList<ScoreMoment> getScoresB() { return momentsB; }

  public void setGame(String gameId) {
    this.momentsA.clear();
    this.momentsB.clear();

    JSONObject json = loadJSONObject("../data/playbyplays/" + gameId + ".json");
    JSONArray playByPlayEvents = json.getJSONArray("resultSets")
                                     .getJSONObject(0)
                                     .getJSONArray("rowSet");

    int quarter = 0;
    String lastTimeString = "";
    int maxA = 0;
    int maxB = 0;
    momentsA.add(new ScoreMoment(0, 0));
    momentsB.add(new ScoreMoment(0, 0));
    for (int i = 0; i < playByPlayEvents.size(); ++i) {
      String timeString = playByPlayEvents.getJSONArray(i).getString(6);
      if (timeString.equals("12:00") && !lastTimeString.equals("12:00")) {
        ++quarter;
        if (quarter == 5) break;
      }
      if (!playByPlayEvents.getJSONArray(i).isNull(10)) {
        String[] minSec = timeString.split(":");
        int gameClock = quarter * 720 -
          (Integer.parseInt(minSec[0]) * 60 + Integer.parseInt(minSec[1]));

        String[] scores = playByPlayEvents.getJSONArray(i)
                                          .getString(10)
                                          .split(" - ");
        int a = Integer.parseInt(scores[1]);
        int b = Integer.parseInt(scores[0]);

        if (a > maxA) { maxA = a; momentsA.add(new ScoreMoment(gameClock, a)); }
        if (b > maxB) { maxB = b; momentsB.add(new ScoreMoment(gameClock, b)); }
      }
      lastTimeString = timeString;
    }
    momentsA.add(new ScoreMoment(2880, maxA));
    momentsB.add(new ScoreMoment(2880, maxB));
  }
}