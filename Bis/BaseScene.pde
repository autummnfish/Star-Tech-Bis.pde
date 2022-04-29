//全てのシーンの基底クラス
public abstract class BaseScene {
  //次のシーンに行きたい時に0~3の値に変更する
  protected int nextScene = -1;

  //開始時に呼び出されるメソッド
  public abstract void Setup();

  //毎フレーム呼び出されるメソッド
  //nextSceneを返す
  public abstract int Update();

  //ゲームシーンの描画をするメソッド
  protected abstract void Draw();

  //マウスを押した時に呼ばれるメソッド
  protected abstract void MousePressed();
  
  //キーを離した時に呼ばれるメソッド
  protected abstract void KeyReleased();

  //シーンの番号を指定して対応するシーンを返すメソッド
  public BaseScene NextScene(int sceneNumber) {
    BaseScene scene = null;
    switch(sceneNumber) {
    case 0:
      scene = new StartScene();
      break;

    case 1:
      scene = new MenuScene();
      break;

    case 2:
      scene = new KoenageScene();
      break;
    }
    return scene;
  }
}
