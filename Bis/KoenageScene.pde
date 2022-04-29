//声投げゲームのシーンの処理をするクラス
public class KoenageScene extends BaseScene {
  //投げれる声の数
  private final int maxKoeCount = 3;

  //投げた声の数
  private int threwKoeCount = 0;

  //録音した声の大きさ
  private float recordingVoiceSize;

  //録音中かどうか
  private boolean isRecording = false;

  //このゲーム中のシーンの番号
  private int sceneKoenage = 0;

  //このゲームのスコア
  private int score = 0;

  //ハイスコアを格納する
  private int[] hiscore;

  //このゲームの表示するハイスコアの数
  private int displayHiscore = 3;

  //次のシーンへ移行するボタン
  private SceneButton sceneButton;

  private Koenage koenage;
  private KoenageStand koenageStand;
  private Person person;

  private TextBox messageBox, resultBox, scoreBox;

  public void Setup() {
    println("KoenageScene");

    sceneButton = new SceneButton(300, 400, 200, 100, "終了", color(0, 255, 0), color(0, 10), 1);
    hiscore = new int[displayHiscore + 1];

    koenageStand = new KoenageStand(PI / 3);
    person = new Person(width / 2, height * 6 / 8);

    messageBox = new TextBox(width / 2 - 250, height / 2, 500, 100, "〜SPACEを押すと録音開始〜", color(0, 255, 0), color(0, 10));
    messageBox.Active();
    resultBox = new TextBox(width / 2 - 200, 100, 400, 300, "リザルト", color(0, 255, 0), color(0, 10));
    scoreBox = new TextBox(width - 150, 0, 150, 100, "スコア\n" + score, color(0, 255, 0), color(0, 10));
    scoreBox.Active();
  }

  //毎フレーム呼ばれる
  public int Update() {
    Draw();

    //条件分岐
    switch(sceneKoenage) {
    case 0: //録音
      messageBox.SetString("〜SPACEを押すと録音開始〜");
      if (isRecording) {
        Recording();
      }
      break;
    case 1: //投げる
      koenage.Update();
      // koenage.Debug();
      if (koenage.GetFinish()) {
        // 当たったかどうか
        /*
          スコア変更用
         */
        for (Bar b : koenageStand.s.b) {
          if (b.GetHit()) {
            continue;
          }
          // 棒の領域内に入ったら当たった
          b.InHitRange(koenage.GetCenterPosition());
          // 当たったのかの判定
          if (b.GetHit()) {
            //hitSound.play();
            score += 40;
          }
        }
        if (threwKoeCount < maxKoeCount - 1) {
          sceneKoenage = 0;
          threwKoeCount++;
        } else {
          sceneKoenage = 2;
          messageBox.NonActive();
        }
      }
      break;
    case 2: //ゲーム終了時
      hiscore = SaveScoreGetHiscore();
      sceneButton.Active();
      resultBox.SetString("今回のスコア：" + score + "\n1位：" + hiscore[0] + "\n2位：" + hiscore[1] + "\n3位：" + hiscore[2]);
      scoreBox.NonActive();
      resultBox.Active();
      sceneKoenage = 3;
      koenageStand.NonActive();
      break;

    case 3: //スコア画面
      DrawSceneButton();
      break;
    }
    return nextScene;
  }

  //シーンの描画をする
  protected void Draw() {
    background.Draw();

    koenageStand.Draw();
    person.Draw();

    messageBox.Draw();
    resultBox.Draw();
    scoreBox.SetString("スコア\n" + score);
    scoreBox.Draw();
  }

  //マウスを押した時に呼ばれるメソッド
  protected void MousePressed() {
    if (sceneButton.IsClick(mouseX, mouseY)) {
      nextScene = sceneButton.GetSceneNumber();
    }
  }

  protected void KeyReleased() {
    if ( sceneKoenage == 0 && keyCode == ' ') {
      isRecording = true;
    }

    if (sceneKoenage == 1) {
      koenage.throwVoice();
    }

    if (sceneKoenage == 0 && keyCode == ENTER && isRecording) {
      isRecording = false;
      sceneKoenage = 1;
      messageBox.SetString("〜ENTERで投げる〜");
      koenage = new Koenage('ワ', person.GetHeadPosition(), recordingVoiceSize);
      recordingVoiceSize = 0;
    }
  }

  //音を録音してrecordingVoiceSizezより大きければそれに格納する
  private void Recording() {
    messageBox.SetString("〜録音中〜ENTERで終了〜");
    float r = amp.analyze();
    recordingVoiceSize = max(r, recordingVoiceSize);
  }

  //スコアを記録し、今回のスコアを含めたハイスコアを返すメソッド
  private int[] SaveScoreGetHiscore() {
    ScoreIO sio = new ScoreIO(displayHiscore);
    int[] hiscore = new int[displayHiscore + 1];
    sio.LoadScore(hiscore);
    hiscore[displayHiscore] = score;
    hiscore = sort(hiscore);
    hiscore = reverse(hiscore);
    sio.SaveScore(hiscore);
    return hiscore;
  }

  //シーンを移行するボタンを描画するメソッド
  private void DrawSceneButton() {
    sceneButton.Draw();
  }
}
