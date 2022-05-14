import java.util.Iterator;

class EventLoader {
  String gameId = "";
  int eventId = 1;
  Table curTable = null;
  HashMap<Integer, Table> tableBuffer = new HashMap<Integer, Table>();

  EventLoader(String gameId) {
    setGameId(gameId);
  }

  public void setGameId(String gameId) {
    this.gameId = gameId;
    setTableIndex(1);
  }

  public void setTableIndex(int tableIndex) {
    if (tableIndex < 1) return;
    if (tableBuffer.size() > 6) tableBuffer.clear();
    tableBuffer.putIfAbsent(tableIndex, loadEventTable(tableIndex));
    tableBuffer.putIfAbsent(tableIndex + 1, loadEventTable(tableIndex + 1));
    tableBuffer.putIfAbsent(tableIndex + 2, loadEventTable(tableIndex + 2));
    eventId = tableIndex;
    curTable = tableBuffer.get(tableIndex);
  }

  public int getEventIndex() {
    return eventId;
  }

  public int getEventMaxMoment() {
    return curTable.getRow(curTable.getRowCount() - 1).getInt(6);
  }

  public Table getEventTableRows(int moment) {
    return new Table(curTable.findRows(Integer.toString(moment), 6));
  }

  public Table getEventTable() {
    return curTable;
  }

  // private int getPrevTableFileIndex(int curTableIndex) {
  //   File file;
  //   int i = curTableIndex;
  //   final int searchCap = curTableIndex - 10;
  //   do {
  //     file = new File("../img/" + gameId + "/" + (--i));
  //     if (i < searchCap) return -1;
  //   } while (!file.exists());
  //   return i;
  // }
  //
  // private int getNextTableFileIndex(int curTableIndex) {
  //   File file;
  //   int i = curTableIndex;
  //   final int searchCap = curTableIndex + 10;
  //   do {
  //     file = new File("../img/" + gameId + "/" + (++i));
  //     if (i > searchCap) return -1;
  //   } while (!file.exists());
  //   return i;
  // }

  private Table loadEventTable(int tableIndex) {
    return loadTable("../data/games/" + gameId + "/" + tableIndex + ".csv");
  }
}
