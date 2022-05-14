class PlayerLoader {
  Table playerTable;
  
  PlayerLoader() {
    playerTable = loadTable("../data/players.csv", "header");
  }
    
  public TableRow getPlayerRow(String playerId) {
    return playerTable.findRow(playerId, "playerid");
  }
}