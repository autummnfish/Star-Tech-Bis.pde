//メニュー画面のクラス
public class MenuScene extends BaseScene {
  //ボタンの配列
  SceneButton[] buttons;



  //開始時に呼び出されるメソッド
  public void Setup() {
    println("MenuScene");

    //if (!bgm.isPlaying()) {
    //  bgm.play();
    //}

    background(0);

    buttons = new SceneButton[1];
    buttons[0] = new SceneButton(width / 2 - 100, height / 2 - 50, 200, 100, "声投げ", color(0, 255, 0), color(0, 10), 2);
    //buttons[1] = new SceneButton(500, 350, 200, 100, "", 3);
    for (Button button : buttons) {
      button.Active();
    }
  }

  //毎フレーム呼び出されるメソッド
  public int Update() {
    Draw();
    return nextScene;
  }

  //ゲームシーンの描画をするメソッド
  protected void Draw() {
    background.Draw();
    MenuDraw();
  }

  //マウスを押した時に呼ばれるメソッド
  protected void MousePressed() {
    for (SceneButton button : buttons) {
      //もしこのボタンがクリックされていたら
      if (button.IsClick(mouseX, mouseY)) {
        //そのボタンに設定されているシーンに移行する
        nextScene = button.GetSceneNumber();
      }
    }
  }

  protected void KeyReleased() {
  }



  //どの屋台(ゲーム)を遊ぶかのメニューを表示(UI)
  private void MenuDraw() {
    for (Button button : buttons) {
      button.Draw();
    }
  }
}
