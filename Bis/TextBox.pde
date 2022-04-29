//文字とその背景を描画するクラス
public class TextBox {
  //xy座標、幅、高さ
  protected int x, y, w, h;

  //このボタンに入れる文字列
  protected String s;

  //このボタンが描画されているか
  protected boolean active = false;

  protected color wordColor, backgroundColor;

  public TextBox() {
  }

  public TextBox(int _x, int _y, int _w, int _h, String _s, color wordCol, color backgroundCol) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    s = _s;
    wordColor = wordCol;
    backgroundColor = backgroundCol;
  }

  //このボタンを描画する
  public void Draw() {
    if (active) {
      push();
      noStroke();
      fill(backgroundColor);
      rect(x, y, w, h);

      fill(wordColor);
      text(s, x, y, w, h);
      pop();
    }
  }

  //このボタンを表示するようにする
  public void Active() {
    active = true;
  }

  //このボタンを表示しなくなる
  public void NonActive() {
    active = false;
  }

  //表示する文字列を設定する
  public void SetString(String _s) {
    s = _s;
  }
}
