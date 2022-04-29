//背景のアニメーションを処理するクラス
public class Background {
  public final int N = width;
  public FuturePoint[] points = new FuturePoint[N];

  public void Setup() {
    for (int i = 0; i < points.length; i++) {
      points[i] = new FuturePoint(10 + 10 * i, 5);
    }
  }
  
  public void Update() {
    for (FuturePoint point : points) {
      point.Update();
    }
  }

  //背景の描画をするメソッド
  public void Draw() {
    push();
    fill(0, 10);
    rect(0, 0, width, height);
    fill(0, 255, 0);
    noStroke();
    for (FuturePoint point : points) {
      point.Draw();
    }
    pop();
  }
}
