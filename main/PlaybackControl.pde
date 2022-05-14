public class PlaybackControl {
  Toolbar toolbar = new Toolbar();
  BtnPlay btnPlay = new BtnPlay(0, 0, 80);
  EventProgressBar eventProgressBar = new EventProgressBar();

  public void draw(boolean isPlaying, float progressRatio) {
    toolbar.draw();
    btnPlay.draw(isPlaying);
    eventProgressBar.draw(progressRatio);
  }
}