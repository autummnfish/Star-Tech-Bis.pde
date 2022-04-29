//声を投げる処理をするクラス
public class Koenage {
  /*
    変数名は後回しにしたからわかりづらい
   */
  // 声の文字
  char voice;
  // 位置
  // 初期位置
  PVector initLocate;
  // 声の位置
  PVector locate;

  private boolean isDisplay = false;
  private boolean isFinish = false;
  private float startTime;
  private float VoiceVelocity;
  private final PVector force = new PVector(0, -3);
  private PVector acceleration;
  private PVector deceleration;
  private int sizeOfText = 64;
  float angle = 0;
  //float d;

  Koenage(char c, PVector xy, float RecordVoice) {
    voice = c;
    initLocate = xy.copy();
    locate = initLocate.copy();
    VoiceVelocity = RecordVoice;
    println(RecordVoice);
    acceleration = force.copy().mult(VoiceVelocity*10 + 1);
    deceleration = acceleration.copy().normalize().mult(-0.5);
  }

  public void Update() {
    show();
    if (isDisplay) {
      move();
    }
  }
  // デバッグ用
  public void Debug() {
    locate.set(mouseX, mouseY);
    println(acceleration.copy().add(deceleration.copy()).mag());
    show();
    if (isDisplay) {
      move();
    }
  }

  public boolean GetFinish() {
    return isFinish;
  }

  private void show() {
    // 表示していいなら
    if (isDisplay) {
      push();
      {
        textSize(sizeOfText);
        strokeWeight(3);
        fill(255, 255, 0);
        stroke(255, 0, 0);
        pushMatrix();
        {
          translate(locate.x, locate.y);
          rotate(angle);
          text(voice, 0, 0);
        }
        popMatrix();
        angle += 0.25;
        /*
          当たり判定可視化
         */
        // ellipse(locate.x, locate.y + sizeOfText/8, 20, 20);
      }
      pop();
    }
  }

  private void move() {
    //現在の座標に音声による倍率をかけたベクトルを加算
    locate.add(acceleration.copy()).add(deceleration.copy());
    deceleration.add(force.copy().normalize().mult(-0.125));

    Finish();
  }

  // 声を投げる
  void throwVoice() {
    isDisplay = true;
    startTime = millis();
    angle = 0;
    locate = initLocate.copy();

    int r = int(random(0, 10+0.1));
    if (r < 4) {
      voice = 'ワ';
    } else if (r < 8) {
      voice = 'ロ';
    } else {
      voice = 'ハ';
    }
  }


  //終了時に呼ばれる
  //投げる処理が終了していたら描画しないようにする
  private void Finish() {
    if (isDisplay
      && (
      millis() - startTime > 5000
      || locate.y < 0
      || locate.y > width
      || acceleration.copy().add(deceleration.copy()).mag() < 1)
      )
    { 
      isDisplay = false;
      isFinish = true;
    }
  }

  public PVector GetPosition() {
    return locate;
  }
  public PVector GetCenterPosition() {
    return new PVector(locate.x, locate.y + sizeOfText/8);
  }

  public char GetVoiceChar() {
    return voice;
  }
}
