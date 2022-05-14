import java.util.HashSet;

final color TEAM_A_COLOR = color(215, 41, 77);
final color TEAM_B_COLOR = color(41, 215, 179);
final color MARKER_COLOR = color(41, 164, 255);

BtnBack btnBack1;
BtnBack btnBack2;
RenderClock renderClock;
EventLoader eventLoader;
GameLoader gameLoader;
GamePicker gamePicker;
PlayerLoader playerLoader;
GameFileCountMap gameFileCountMap;
PlayByPlayLoader playByPlayLoader;
ScoreTrend scoreTrend;
PlaybackControl playbackControl;
GameRenderer gameRenderer;
GameInfoPanel gameInfoPanel;
PlayerInfoPanel playerInfoPanel = new PlayerInfoPanel();
TeamLoader teamLoader;
ForceDirectedGraph forceDirectedGraph;

int page = 0;
String gameId;
String teamIdA;
String teamIdB;
TeamPlayers playersA = new TeamPlayers();
TeamPlayers playersB = new TeamPlayers();
float progressRatio = 0;
int eventId = 0;
int eventCount = 0;
boolean isPlaying = false;
boolean eventPlaybackDragLock = false;
boolean gamePlaybackDragLock = false;

void setup() {
  fullScreen(P2D);
  pixelDensity(displayDensity());
  smooth(8);
  textFont(createFont("../font/OpenSans-Regular.ttf", 18, true));

  renderClock = new RenderClock();
  gameFileCountMap = new GameFileCountMap();

  gameId = "0041400101";
  eventLoader = new EventLoader(gameId);
  eventId = eventLoader.getEventIndex();
  eventCount = gameFileCountMap.getGameFileCount(gameId);

  btnBack1 = new BtnBack();
  btnBack2 = new BtnBack();
  playByPlayLoader = new PlayByPlayLoader(gameId);
  scoreTrend = new ScoreTrend(80, 0, width - 80, 80);
  playbackControl = new PlaybackControl();
  gameRenderer = new GameRenderer();
  gameInfoPanel = new GameInfoPanel();
  teamLoader = new TeamLoader();
  playerLoader = new PlayerLoader();
  gameLoader = new GameLoader();
  gamePicker = new GamePicker();

  forceDirectedGraph = createForceDirectedGraph();
  forceDirectedGraph.set((width - 1280) / 2, (height - 720) / 2, 1280, 720);
}

void draw() {
  background(255);

  switch(page) {
    case 0:
      forceDirectedGraph.draw();
      break;
    case 1:
      gamePicker.draw(teamIdA, teamIdB);
      btnBack1.draw();
      break;
    case 2:
      if (!eventPlaybackDragLock && isPlaying) renderClock.increment();
      int curTimeStep = renderClock.getTimeStep();

      progressRatio = (float) curTimeStep / eventLoader.getEventMaxMoment();
      if (progressRatio > 0.999 && eventId < eventCount) {
        ++eventId;
        eventLoader.setTableIndex(eventId);
        renderClock.reset();
      }
      playbackControl.draw(isPlaying, progressRatio);
      gameRenderer.draw(eventLoader.getEventTableRows(curTimeStep));
      scoreTrend.draw(playByPlayLoader.getScoresA(),
                      playByPlayLoader.getScoresB());
      gameInfoPanel.draw(playByPlayLoader.getScoresA(),
                         playByPlayLoader.getScoresB());
      playerInfoPanel.draw();
      btnBack2.draw();
      break;
  }
}

void mouseMoved() {
  switch(page) {
    case 0:
      if(forceDirectedGraph.isIntersectingWith(mouseX, mouseY)) {
        forceDirectedGraph.onMouseMovedAt(mouseX, mouseY);
      } else {
        cursor(ARROW);
      }
      break;
    case 1:
      gamePicker.onMouseMoved();
      break;
    case 2:
      float draggerPos = width * progressRatio;
      if (mouseY > 75 && mouseY <= 93 && mouseX > draggerPos - 10 && mouseX <= draggerPos + 10) {
        cursor(HAND);
      } else if (mouseX > 80 && mouseY <= 80) {
        cursor(HAND);
      } else if (mouseX <= 80 && mouseY <= 80) {
        cursor(HAND);
      } else if (mouseY > 120 && mouseY <= 160 && mouseX <= 50) {
        cursor(HAND);
      } else {
        cursor(ARROW);
      }
      playerInfoPanel.onMouseMoved();
      break;
  }
}

void mousePressed() {
  switch(page) {
    case 0:
      if (forceDirectedGraph.isIntersectingWith(mouseX, mouseY)) {
        forceDirectedGraph.onMousePressedAt(mouseX, mouseY);
      }
      break;
    case 1:
      gamePicker.onMousePressed();
      if (mouseY > 120 && mouseY <= 160 && mouseX <= 50) {
        page = 0;
      }
      break;
    case 2:
      float eventDraggerPos = width * progressRatio;
      if (mouseX > 90 && mouseX <= width - 10 && mouseY <= 80) {
          eventId = Math.round((mouseX - 90) * eventCount / (width - 100)) + 1;
          if (eventId > eventCount) eventId = eventCount;
          eventLoader.setTableIndex(eventId);
          renderClock.reset();
      } else if (mouseY > 80 && mouseY <= 88) {
        if (mouseX > eventDraggerPos - 10 && mouseX <= eventDraggerPos + 10) {
          eventPlaybackDragLock = true;
        } else {
          renderClock.setTimeStep(mouseX * eventLoader.getEventMaxMoment() / width);
        }
      } else if (mouseX <= 80 && mouseY <= 80) {
        isPlaying = !isPlaying;
      } else if (mouseY > 120 && mouseY <= 160 && mouseX <= 50) {
        page = 1;
      }
      playerInfoPanel.onMousePressed();
      break;
  }
}

void mouseDragged() {
  switch(page) {
    case 0:
      if (forceDirectedGraph.isIntersectingWith(mouseX, mouseY)) {
        forceDirectedGraph.onMouseDraggedTo(mouseX, mouseY);
      }
      break;
    case 2:
      if (eventPlaybackDragLock) {
        renderClock.setTimeStep(mouseX * eventLoader.getEventMaxMoment() / width);
      } else if (gamePlaybackDragLock) {
        eventLoader.setTableIndex(mouseX * gameFileCountMap.getGameFileCount(gameId) / width);
      }
      break;
  }
}

void mouseReleased() {
  switch(page) {
    case 0:
      if (forceDirectedGraph.isIntersectingWith(mouseX, mouseY)) {
        forceDirectedGraph.onMouseReleased();
      }
      break;
    case 2:
      if (eventPlaybackDragLock) {
        eventPlaybackDragLock = false;
      } else if (gamePlaybackDragLock) {
        gamePlaybackDragLock = false;
      }
      break;
  }
}

ForceDirectedGraph createForceDirectedGraph() {
  ForceDirectedGraph forceDirectedGraph = new ForceDirectedGraph();

  Table teamTable = loadTable("../data/team.csv", "header");
  int nodeId = 0;
  for (TableRow row : teamTable.rows()) {
    int teamId = row.getInt("teamid");
    float mass = teamLoader.getTeam(Integer.toString(teamId)).winPercent;
    forceDirectedGraph.add(new Node(teamId, nodeId, mass));
    ++nodeId;
  }

  Table gameTable = loadTable("../data/games.csv", "header");
  for (TableRow row : gameTable.rows()) {
    int teamId1 = row.getInt("hometeamid");
    int teamId2 = row.getInt("visitorteamid");
    float strength = 200.0f;
    forceDirectedGraph.addEdge(teamId1, teamId2, strength);
  }

  return forceDirectedGraph;
}