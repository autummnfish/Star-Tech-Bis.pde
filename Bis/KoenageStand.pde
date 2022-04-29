// 輪投げ台のクラス
public class KoenageStand {
  private Stand s;
  private boolean active = true;

  // 台の角度
  private float angle = PI / 4;

  KoenageStand(float _angle) {
    angle = _angle;
    ///////////////////p = new Person(width/2, height*6/8);
    s = new Stand(width / 2, height / 4 + 10, angle);
  }

  // 描画
  public void Draw() {
    if(active) {
      s.Draw();
    }
  }
  
  public void NonActive() {
    active = false;
  }
}

// 輪投げの目標物である棒クラス
public class Bar {
  private float locateX, locateY;
  private float standX, standY;
  private int size = 10;
  private int len = 50;
  private float h;
  private float rad;
  private float hitDiameter = 80;
  private float hitDiameterPadding = 50;
  private boolean isHit = false;
  private color barColor = color(255, 0, 255);


  Bar(float x, float y, float angle, float stdX, float stdY) {
    locateX = x;
    locateY = y;
    // 台の角度で描画の長さを変える
    h = len/2;
    rad = angle;
    standX = stdX;
    standY = stdY;
  }
  /*
   じっくり見ると作りが荒い感じになってる
   それっぽいからOK
   */
  public void Draw() {
    if (!isHit) {
      Show();
    }
    Move();
  }
  // 棒の描画
  private void Show() {
    push();
    {
      noFill();
      ellipse(locateX, locateY, hitDiameter, hitDiameter);
      //ellipse(locateX, locateY, hitDiameter + hitDiameterPadding, hitDiameter + hitDiameterPadding);

      fill(barColor);
      ellipse(locateX, locateY, size, size);
      rect(locateX - size/2, locateY - h, size, h);
      ellipse(locateX, locateY - h, size, size);
    }
    pop();
  }

  private void Move() {
    locateX = standX+ width/10*cos(rad);
    locateY = standY+ height/10*sin(rad);
    rad += 0.01;
  }

  public void InHitRange(PVector another) {
    if (dist(locateX, locateY, another.x, another.y) < hitDiameter/2 + hitDiameterPadding/2) {
      isHit = true;
    }
  }

  public boolean GetHit() {
    return isHit;
  }
}

// 輪投げ台そのもの　のクラス
class Stand {
  // 台の"中心"
  public PVector center;
  // 遠近感のための余白
  private float padding;
  public float len, h;
  private color standColor = color(#7700ff);

  private Bar[] b;

  public Stand(int x, int y, float angle) {
    center = new PVector(x, y);
    len = height/2 - padding;
    // 角度によって見える高さが変わる
    h = len*sin(angle);
    // 角度が小さいと遠近感が強くなる
    padding = map(angle, 0, PI/2, 20, 0);

    // 棒の位置初期化
    b = new Bar[4];
    for (int i = 0; i < b.length; i++) {
      /*
        スタンドの中心を基準にしたから
       コードが分かりづらくなっちゃった
       */
      // スタンドに円上で配置
      b[i] = new Bar(
        center.x + len/3 * cos(TWO_PI/b.length * i), 
        center.y + h/3 * sin(TWO_PI/b.length * i), 
        TWO_PI/b.length * i, center.x, center.y
        );
    }
  }

  // 台の描画
  public void Draw() {
    /*
      ややこしいのは基準を中心にしたせい
     自分の頭じゃ中心じゃないとわからん
     */
    push();
    {
      fill(standColor);
      quad(
        center.x - len/2 + padding, center.y - h/2 + padding, 
        center.x + len/2 - padding, center.y - h/2 + padding, 
        center.x + len/2 + padding, center.y + h/2 + padding, 
        center.x - len/2 - padding, center.y + h/2 + padding
        );
    }
    pop();

    // 棒の表示と移動
    for (Bar bar : b) {
      if (!bar.GetHit()) {
        bar.Draw();
      }
    }
  }
}
