// マイクの音を扱うためのライブラリのインポート
import processing.sound.*;

//現在のシーン
public BaseScene currentScene;

public Background background;

// マイク
public AudioIn in;
// 音量を取得してくれるもの
public Amplitude amp;

public SoundFile bgm, buttonSound, hitSound;

public final int textSize = 30;

void setup() {
  size(800, 800);

  //bgm = new SoundFile(this, "BGM.mp3");
  //bgm.amp(0.1);
  //buttonSound = new SoundFile(this, "ButtonSound.mp3");
  //buttonSound.amp(0.15);
  //hitSound = new SoundFile(this, "HitSound.mp3");
  //hitSound.amp(0.1);

  textFont(createFont("Menlo", textSize));
  textAlign(CENTER, CENTER);

  background = new Background();
  background.Setup();

  currentScene = new StartScene();
  currentScene.Setup();

  // マイクを初期化
  in = new AudioIn(this);
  in.start();

  // 音量の取得を開始
  amp = new Amplitude(this);
  amp.input(in);
}

void draw() {
  background.Update();
  int scene = currentScene.Update();

  if (scene != -1) {
    currentScene = currentScene.NextScene(scene);
    currentScene.Setup();
  }
}

void mousePressed() {
  currentScene.MousePressed();
}

void keyReleased() {
  currentScene.KeyReleased();
}
