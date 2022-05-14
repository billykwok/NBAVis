public class ForceDirectedGraph extends Viewport {

  private static final float TOTAL_KINETIC_ENERGY_DEFAULT = MAX_FLOAT;
  public static final float SPRING_CONSTANT_DEFAULT       = 0.2f;
  public static final float COULOMB_CONSTANT_DEFAULT      = 100.0f;
  public static final float DAMPING_COEFFICIENT_DEFAULT   = 0.1f;
  public static final float TIME_STEP_DEFAULT             = 0.8f;

  private ArrayList<Node> nodes;
  private float totalKineticEnergy;
  private float springConstant;
  private float coulombConstant;
  private float dampingCoefficient;
  private float timeStep;
  private boolean[] edgeState = new boolean[162];

  private Node lockedNode;
  private Node dummyCenterNode; //for pulling the glaph to center

  public ForceDirectedGraph() {
    super();
    this.nodes = new ArrayList<Node>();
    this.totalKineticEnergy = TOTAL_KINETIC_ENERGY_DEFAULT;
    this.springConstant = SPRING_CONSTANT_DEFAULT;
    this.coulombConstant = COULOMB_CONSTANT_DEFAULT;
    this.dampingCoefficient = DAMPING_COEFFICIENT_DEFAULT;
    this.timeStep = TIME_STEP_DEFAULT;

    this.lockedNode = null;
    this.dummyCenterNode = new Node(-1, -1, 1.0f);
    for (boolean boo : this.edgeState) boo = false;
  }

  public void add(Node node) {
    this.nodes.add(node);
  }
  public void addEdge(int id1, int id2, float naturalSpringLength) {
    Node node1 = this.getNodeWith(id1);
    Node node2 = this.getNodeWith(id2);
    node1.add(node2, naturalSpringLength);
    node2.add(node1, naturalSpringLength);
  }
  private Node getNodeWith(int id) {
    Node node = null;
    for (int i = 0; i < this.nodes.size(); ++i) {
      Node target = this.nodes.get(i);
      if (target.getID() == id) { node = target; break; }
    }
    return node;
  }

  //@Override
  public void set(float viewX, float viewY, float viewWidth, float viewHeight) {
    super.set(viewX, viewY, viewWidth, viewHeight);
    if (this.dummyCenterNode != null) {
      this.dummyCenterNode.set(this.getCenterX(), this.getCenterY(), 1.0f);
      this.initializeNodeLocations();
    }
  }
  private void initializeNodeLocations() {
    float maxMass = 0.0f;
    for (int i = 0; i < this.nodes.size(); ++i) {
      float mass = this.nodes.get(i).getMass();
      if (mass > maxMass) maxMass = mass;
    }
    float nodeSizeRatio;
    if (this.getWidth() < this.getHeight()) {
      nodeSizeRatio = this.getWidth() * 0.25f / maxMass;
    } else {
      nodeSizeRatio = this.getHeight() * 0.25f / maxMass;
    }
    float offset = nodeSizeRatio * maxMass;
    float minXBound = this.getX() + offset;
    float maxXBound = this.getX() + this.getWidth() - offset;
    float minYBound = this.getY() + offset;
    float maxYBound = this.getY() + this.getHeight() - offset;
    for (int i = 0; i < this.nodes.size(); ++i) {
      Node node = this.nodes.get(i);
      float x = random(minXBound, maxXBound);
      float y = random(minYBound, maxYBound);
      float d = node.getMass() * nodeSizeRatio;
      node.set(x, y, d);
    }
  }

  public void draw() {
    textAlign(LEFT, CENTER);
    fill(80);
    textSize(32);
    text("NBA 2014-15 Visualization", 40, 60);
    fill(144);
    textSize(16);
    text("Please begin by selecting a link (game)...", 40, 100);
    this.totalKineticEnergy = this.calculateTotalKineticEnergy();
    strokeWeight(3.0f);
    this.drawEdges();
    for (int i = 0; i < this.nodes.size(); ++i) this.nodes.get(i).draw();
  }

  private void drawEdges() {
    int i = 0;
    for (Node node : this.nodes) {
      int noOfAdf = node.getSizeOfAdjacents();
      for (Node adjNode : node.getAdjacents()) {
        strokeWeight(1.0f * noOfAdf);
        if (this.edgeState[i]) {
          stroke(252, 142, 27);
        } else {
          stroke(120);
        }
        line(node.getX(), node.getY(), adjNode.getX(), adjNode.getY());
        float midX = (node.getX() + adjNode.getX()) / 2;
        float midY = (node.getY() + adjNode.getY()) / 2;
        strokeWeight(3.0f);
        ++i;
      }
    }
  }

  private float calculateTotalKineticEnergy() {
    float totalKineticEnergy = 0.0f;
    for (int i = 0; i < this.nodes.size(); ++i) {
      Node target = this.nodes.get(i);
      if (target == this.lockedNode) continue;

      float forceX = 0.0f;
      float forceY = 0.0f;
      for (int j = 0; j < this.nodes.size(); ++j) { //Coulomb's law
        Node node = this.nodes.get(j);
        if (node != target) {
          float dx = target.getX() - node.getX();
          float dy = target.getY() - node.getY();
          float rSquared = dx * dx + dy * dy + 0.0001f; //to avoid zero deviation
          float coulombForceX = this.coulombConstant * dx / rSquared;
          float coulombForceY = this.coulombConstant * dy / rSquared;
          forceX += coulombForceX;
          forceY += coulombForceY;
        }
      }

      if (this.dummyCenterNode != null) { //for centering the graph //super ad-hoc
        float dummyDx = target.getX() - this.dummyCenterNode.getX();
        float dummyDy = target.getY() - this.dummyCenterNode.getY();
        if (dummyDx > 10.0f || dummyDy > 10.0f) {
          float dummyRSquared = dummyDx * dummyDx + dummyDy * dummyDy + 0.0001f; //to avoid zero deviation
          float dummyCoulombForceX = this.coulombConstant * dummyDx / dummyRSquared;
          float dummyCoulombForceY = this.coulombConstant * dummyDy / dummyRSquared;
          forceX -= dummyCoulombForceX / 10.0f;
          forceY -= dummyCoulombForceY / 10.0f;
        }
      }

      for (int j = 0; j < target.getSizeOfAdjacents(); ++j) { //Hooke's law
        Node node = target.getAdjacentAt(j);
        float springLength = target.getNaturalSpringLengthAt(j);
        float dx = node.getX() - target.getX();
        float dy = node.getY() - target.getY();

        float l = sqrt(dx * dx + dy * dy) + 0.0001f; //to avoid zero deviation
        float springLengthX = springLength * dx / l;
        float springLengthY = springLength * dy / l;
        float springForceX = this.springConstant * (dx - springLengthX);
        float springForceY = this.springConstant * (dy - springLengthY);

        forceX += springForceX;
        forceY += springForceY;
      }

      float accelerationX = forceX / target.getMass();
      float accelerationY = forceY / target.getMass();

      float velocityX = (target.getVelocityX() + this.timeStep * accelerationX) * this.dampingCoefficient;
      float velocityY = (target.getVelocityY() + this.timeStep * accelerationY) * this.dampingCoefficient;

      float x = target.getX() + this.timeStep * velocityX + accelerationX * pow(this.timeStep, 2.0f) / 2.0f;
      float y = target.getY() + this.timeStep * velocityY + accelerationY * pow(this.timeStep, 2.0f) / 2.0f;

      float radius = target.getDiameter() / 2.0f; //for boundary check
      if (x < this.getX() + radius) {
        x = this.getX() + radius;
      } else if (x > this.getX() + this.getWidth() - radius) {
        x =  this.getX() + this.getWidth() - radius;
      }
      if (y < this.getY() + radius) {
        y = this.getY() + radius;
      } else if (y > this.getY() + this.getHeight() - radius) {
        y =  this.getX() + this.getHeight() - radius;
      }

      target.set(x, y);
      target.setVelocities(velocityX, velocityY);

      totalKineticEnergy += (target.getMass() * pow((velocityX + velocityY), 2.0f));
    }
    return totalKineticEnergy;
  }

  public void onMouseMovedAt(int x, int y) {
    boolean isEnterCircle = false;
    for (int i = 0; i < this.nodes.size(); ++i) {
      Node node = this.nodes.get(i);
      if (node.isIntersectingWith(x, y)) {
        cursor(HAND);
        node.highlight();
        isEnterCircle = true;
        break;
      } else {
        node.dehighlight();
      }
    }
    if (!isEnterCircle) {
      int j = 0;
      for (Node node : this.nodes) {
        for (Node adjNode : node.getAdjacents()) {
          if (pointToLineDistance(node, adjNode, mouseX, mouseY) < 10 &&
              mouseX > Math.min(node.getX(), adjNode.getX()) &&
              mouseX < Math.max(node.getX(), adjNode.getX()) &&
              mouseY > Math.min(node.getY(), adjNode.getY()) &&
              mouseY < Math.max(node.getY(), adjNode.getY())) {
            cursor(HAND);
            this.edgeState[j] = true;
          } else {
            this.edgeState[j] = false;
          }
          ++j;
        }
      }
    }
  }
  public void onMousePressedAt(int x, int y) {
    boolean isPressedCircle = false;
    for (Node node : this.nodes) {
      if (node.isIntersectingWith(x, y)) {
        this.lockedNode = node;
        this.lockedNode.setVelocities(0.0f, 0.0f);
        isPressedCircle = true;
        break;
      }
    }
    if (!isPressedCircle) {
      for (Node node : this.nodes) {
        for (Node adjNode : node.getAdjacents()) {
          if (pointToLineDistance(node, adjNode, mouseX, mouseY) < 10 &&
              mouseX > Math.min(node.getX(), adjNode.getX()) &&
              mouseX < Math.max(node.getX(), adjNode.getX()) &&
              mouseY > Math.min(node.getY(), adjNode.getY()) &&
              mouseY < Math.max(node.getY(), adjNode.getY())) {
            teamIdA = Integer.toString(node.getID());
            teamIdB = Integer.toString(adjNode.getID());
            page = 1;
            return;
          }
        }
      }
    }
  }
  public void onMouseDraggedTo(int x, int y) {
    if (this.lockedNode != null) {
      float radius = this.lockedNode.getDiameter() / 2.0f;
      if (x < this.getX() + radius) {
        x = (int)(this.getX() + radius);
      } else if (x > this.getX() + this.getWidth() - radius)
        x =  (int)(this.getX() + this.getWidth() - radius);
      if (y < this.getY() + radius) {
        y = (int)(this.getY() + radius);
      } else if (y > this.getY() + this.getHeight() - radius)
        y =  (int)(this.getX() + this.getHeight() - radius);

      this.lockedNode.set(x, y);
      this.lockedNode.setVelocities(0.0f, 0.0f);
    }
  }
  public void onMouseReleased() {
    this.lockedNode = null;
  }
  public double pointToLineDistance(Node a, Node b, float x, float y) {
    double normalLength = Math.sqrt((b.getX() - a.getX()) * (b.getX() - a.getX()) + (b.getY() - a.getY()) * (b.getY() - a.getY()));
    return Math.abs((x - a.getX()) * (b.getY()-a.getY()) - (y - a.getY()) * (b.getX() - a.getX())) / normalLength;
  }
}
