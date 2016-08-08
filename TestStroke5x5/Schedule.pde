import java.util.TimerTask;

public class Schedule extends TimerTask {
  TestStroke5x5 parent;

  public Schedule(TestStroke5x5 p) {
    super();
    parent = p;
  }

  public void run() {
    parent.message();
  }
}