color[] colorScheme = {
  color(153, 204, 51),
  color(77, 204, 51),
  color(51, 204, 102),
  color(51, 204, 179),
  color(51, 153, 204),
  color(51, 77, 204),
  color(102, 51, 204),
  color(179, 51, 204),
  color(204, 51, 153),
  color(204, 51, 77),
  color(204, 102, 51),
  color(204, 179, 51),
  color(177, 216, 100),
  color(202, 228, 149),
  color(139, 100, 216),
  color(175, 149, 228)
};

public class Node {
  private int id;
  private int nodeId;
  private float mass;
  private ArrayList<Node> adjacents;
  private ArrayList<Float> naturalSpringLengths;
  private float x;
  private float y;
  private float diameter;
  private float velocityX;
  private float velocityY;
  private boolean isHighlighted;

  public Node(int id, int nodeId, float mass) {
    this.id = id;
    this.nodeId = nodeId;
    this.mass = mass;
    this.adjacents = new ArrayList<Node>();
    this.naturalSpringLengths = new ArrayList<Float>();

    this.set(-1.0f, -1.0f, -1.0f);
    this.setVelocities(0.0f, 0.0f);
    this.isHighlighted = false;
  }

  public void add(Node adjacent, float naturalSpringLength) {
    this.adjacents.add(adjacent);
    this.naturalSpringLengths.add(naturalSpringLength);
  }
  public void set(float x, float y) {
    this.x = x;
    this.y = y;
  }
  public void set(float x, float y, float diameter) {
    this.set(x, y);
    this.diameter = diameter;
  }
  public void setVelocities(float velocityX, float velocityY) {
    this.velocityX = velocityX;
    this.velocityY = velocityY;
  }

  public int getID() {
    return this.id;
  }
  public float getMass() {
    return this.mass;
  }
  public float getX() {
    return this.x;
  }
  public float getY() {
    return this.y;
  }
  public float getDiameter() {
    return this.diameter;
  }
  public float getVelocityX() {
    return this.velocityX;
  }
  public float getVelocityY() {
    return this.velocityY;
  }
  public int getSizeOfAdjacents() {
    return this.adjacents.size();
  }
  public ArrayList<Node> getAdjacents() {
    return this.adjacents;
  }
  public Node getAdjacentAt(int index) {
    return this.adjacents.get(index);
  }
  public float getNaturalSpringLengthAt(int index) {
    return this.naturalSpringLengths.get(index);
  }

  public void draw() {
    if (this.isHighlighted) {
      stroke(180);
      fill(230);
    } else {
      stroke(220);
      fill(240);
    }
    ellipse(this.x, this.y, this.diameter, this.diameter);

    pushMatrix();
    translate(this.x, this.y);
    imageMode(CENTER);
    PImage logo = teamLoader.getTeam(Integer.toString(this.id)).logo;
    logo.resize((int) this.diameter, (int) this.diameter);
    image(logo, 0, 0);
    imageMode(CORNER);
    popMatrix();

    if (this.isHighlighted) {
      fill(255, 180);
      ellipse(this.x, this.y, this.diameter, this.diameter);
      fill(0);
      textAlign(CENTER, BOTTOM);
      textSize(24);
      text(teamLoader.getTeam(Integer.toString(this.id)).name, this.x, this.y);
      textAlign(CENTER, TOP);
      textSize(16);
      text("Won " + teamLoader.getTeam(Integer.toString(this.id)).winCount + " games in total", this.x, this.y);
    }
  }

  public void highlight() {
    this.isHighlighted = true;
  }

  public void dehighlight() {
    this.isHighlighted = false;
  }

  public boolean isIntersectingWith(int x, int y) {
    float r = this.diameter / 2.0f;
    if (this.x - r <= x && x <= this.x + r && this.y - r <= y && y <= this.y + r) {
      return true;
    } else {
      return false;
    }
  }
}
