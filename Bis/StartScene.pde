//開始画面のクラス
public class StartScene extends BaseScene {
  Button[] buttons;

  private float t = 0;
  private int time = 0;
  
  PImage rogo;

  //開始時に呼び出されるメソッド
  public void Setup() {
    println("StartScene");
    time = millis();
    
    rogo = loadImage("starTech.png");
  }

  //毎フレーム呼び出されるメソッド
  public int Update() {
    Draw();
    
    if(5500 < millis() - time) {
      nextScene = 1;
    }
    return nextScene;
  }

  //描画をするメソッド
  protected void Draw() {
    //開始時のダイブする？演出の描画
    push();
    noStroke();
    fill(0, 31);
    translate(width/2, height/2);
    rect(-width/2, -height/2, width*2, height*2);
    for (float u = t; u < TAU+t; u += PI/width) {
      rotate(u-t);
      fill(0, 255, 0);
      float x = 400*(sin(u) - cos(t));//*noise(u);
      float y = 400*(-sin(t) + cos(u));//*noise(t);
      circle(x, y, abs(acos(sin(u))));
    }
    t += PI/180;
    pop();
    
    push();
    {
      tint(255, 20);
      image(rogo, width/2 - rogo.width/2, height/2 - rogo.height/2);
    }
    pop();
  }

  //マウスを押した時に呼ばれるメソッド
  protected void MousePressed() {
  }

  protected void KeyReleased() {
  }
}
