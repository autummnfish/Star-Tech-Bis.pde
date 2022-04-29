//シーンを移行するボタン
public class SceneButton extends Button {
  //このボタンを押したら遷移するシーンの番号
  private int nextSceneNumber = -1;

  public SceneButton(int _x, int _y, int _w, int _h, String _s, color wordCol, color buttonCol, int sceneNumber) {
    super(_x, _y, _w, _h, _s, wordCol, buttonCol);
    nextSceneNumber = sceneNumber;
  }

  //このボタンを押したら遷移するシーンの番号を取得する
  public int GetSceneNumber() {
    return nextSceneNumber;
  }
}
