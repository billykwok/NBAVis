public class RenderClock {
  final int playSpeed = 20;
  int prevTime = 0;
  int timeStep = 0;

  public void increment() {
    if (millis() - prevTime >= playSpeed) {
      ++timeStep;
      prevTime = millis();
    }
  }
  
  public void setTimeStep(int timeStep) {
    this.timeStep = timeStep;
  }

  public int getTimeStep() {
    return timeStep;
  }

  public void reset() {
    prevTime = 0;
    timeStep = 0;
  }
}