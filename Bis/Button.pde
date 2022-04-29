//UIのボタンを表示、クリックされたかを処理するクラス
public class Button extends TextBox{
  public Button() {
  }

  public Button(int _x, int _y, int _w, int _h, String _s, color wordCol, color buttonCol) {
    super(_x, _y, _w, _h, _s, wordCol, buttonCol);
  }

  //クリックされているかどうかを確かめる
  public boolean IsClick(int mx, int my) {
    if((x <= mx && mx <= x + w) && (y <= my && my <= y + h) && active) {
      //buttonSound.play();
      return true;
    }
    
    return false;
  }
}
