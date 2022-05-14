class LogoLoader {
  HashMap<String, PImage> logos = new HashMap<String, PImage>();

  LogoLoader() {
    logos.putIfAbsent("1610612737", loadImage("../data/logos/ATL_logo.png"));
    logos.putIfAbsent("1610612738", loadImage("../data/logos/BOS_logo.png"));
    logos.putIfAbsent("1610612739", loadImage("../data/logos/CLE_logo.png"));
    logos.putIfAbsent("1610612740", loadImage("../data/logos/NOP_logo.png"));
    logos.putIfAbsent("1610612741", loadImage("../data/logos/CHI_logo.png"));
    logos.putIfAbsent("1610612742", loadImage("../data/logos/DAL_logo.png"));
    logos.putIfAbsent("1610612744", loadImage("../data/logos/GSW_logo.png"));
    logos.putIfAbsent("1610612745", loadImage("../data/logos/HOU_logo.png"));
    logos.putIfAbsent("1610612746", loadImage("../data/logos/LAC_logo.png"));
    logos.putIfAbsent("1610612749", loadImage("../data/logos/MIL_logo.png"));
    logos.putIfAbsent("1610612751", loadImage("../data/logos/BKN_logo.png"));
    logos.putIfAbsent("1610612757", loadImage("../data/logos/POR_logo.png"));
    logos.putIfAbsent("1610612759", loadImage("../data/logos/SAS_logo.png"));
    logos.putIfAbsent("1610612761", loadImage("../data/logos/TOR_logo.png"));
    logos.putIfAbsent("1610612763", loadImage("../data/logos/MEM_logo.png"));
    logos.putIfAbsent("1610612764", loadImage("../data/logos/WAS_logo.png"));
  }

  public PImage getLogo(String teamId) {
    return logos.get(teamId);
  }
}
