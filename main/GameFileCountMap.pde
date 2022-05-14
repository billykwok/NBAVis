class GameFileCountMap {
  HashMap<String, Integer> map = new HashMap<String, Integer>(81);

  GameFileCountMap() {
    map.putIfAbsent("0041400101", 429); map.putIfAbsent("0041400102", 432);
    map.putIfAbsent("0041400103", 258); map.putIfAbsent("0041400104", 486);
    map.putIfAbsent("0041400105", 353); map.putIfAbsent("0041400106", 444);
    map.putIfAbsent("0041400111", 438); map.putIfAbsent("0041400112", 425);
    map.putIfAbsent("0041400113", 266); map.putIfAbsent("0041400114", 315);
    map.putIfAbsent("0041400121", 487); map.putIfAbsent("0041400122", 457);
    map.putIfAbsent("0041400123", 505); map.putIfAbsent("0041400124", 449);
    map.putIfAbsent("0041400125", 479); map.putIfAbsent("0041400126", 430);
    map.putIfAbsent("0041400131", 489); map.putIfAbsent("0041400132", 462);
    map.putIfAbsent("0041400133", 484); map.putIfAbsent("0041400134", 444);
    map.putIfAbsent("0041400141", 482); map.putIfAbsent("0041400142", 444);
    map.putIfAbsent("0041400143", 518); map.putIfAbsent("0041400144", 405);
    map.putIfAbsent("0041400151", 474); map.putIfAbsent("0041400152", 446);
    map.putIfAbsent("0041400153", 428); map.putIfAbsent("0041400154", 495);
    map.putIfAbsent("0041400155", 509); map.putIfAbsent("0041400161", 482);
    map.putIfAbsent("0041400162", 490); map.putIfAbsent("0041400163", 408);
    map.putIfAbsent("0041400164", 475); map.putIfAbsent("0041400165", 525);
    map.putIfAbsent("0041400166", 437); map.putIfAbsent("0041400167", 443);
    map.putIfAbsent("0041400171", 484); map.putIfAbsent("0041400172", 419);
    map.putIfAbsent("0041400173", 435); map.putIfAbsent("0041400174", 411);
    map.putIfAbsent("0041400175", 476); map.putIfAbsent("0041400201", 456);
    map.putIfAbsent("0041400202", 437); map.putIfAbsent("0041400203", 441);
    map.putIfAbsent("0041400204", 458); map.putIfAbsent("0041400205", 455);
    map.putIfAbsent("0041400206", 467); map.putIfAbsent("0041400211", 384);
    map.putIfAbsent("0041400212", 443); map.putIfAbsent("0041400213", 435);
    map.putIfAbsent("0041400214", 443); map.putIfAbsent("0041400215", 459);
    map.putIfAbsent("0041400216", 388); map.putIfAbsent("0041400221", 339);
    map.putIfAbsent("0041400222", 441); map.putIfAbsent("0041400223", 421);
    map.putIfAbsent("0041400224", 451); map.putIfAbsent("0041400225", 395);
    map.putIfAbsent("0041400226", 439); map.putIfAbsent("0041400231", 395);
    map.putIfAbsent("0041400232", 478); map.putIfAbsent("0041400233", 431);
    map.putIfAbsent("0041400234", 557); map.putIfAbsent("0041400235", 479);
    map.putIfAbsent("0041400236", 520); map.putIfAbsent("0041400237", 462);
    map.putIfAbsent("0041400301", 450); map.putIfAbsent("0041400302", 421);
    map.putIfAbsent("0041400303", 535); map.putIfAbsent("0041400304", 451);
    map.putIfAbsent("0041400311", 472); map.putIfAbsent("0041400312", 415);
    map.putIfAbsent("0041400313", 498); map.putIfAbsent("0041400314", 475);
    map.putIfAbsent("0041400315", 524); map.putIfAbsent("0041400401", 447);
    map.putIfAbsent("0041400402", 534); map.putIfAbsent("0041400403", 447);
    map.putIfAbsent("0041400404", 473); map.putIfAbsent("0041400405", 459);
    map.putIfAbsent("0041400406", 480);
  }

  public int getGameFileCount(String gameId) {
    return map.getOrDefault(gameId, 0);
  }
}
