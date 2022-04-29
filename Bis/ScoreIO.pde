public class ScoreIO {
  //表示する、保存するスコアの件数
  private int saveCount;

  public ScoreIO(int _saveCount) {
    saveCount = _saveCount;
  }

  //スコアを読み込む
  public void LoadScore(int[] scores) {
    String[] text = loadStrings("data/KoenageScore.txt");

    for (int i = 0; i < saveCount; i++) {
      scores[i] = int(text[i]);
    }
  }

  //スコアを保存する
  public void SaveScore(int[] scores) {
    String[] text = new String[saveCount];

    for (int i = 0; i < saveCount; i++) {
      text[i] = str(scores[i]);
    }

    saveStrings("data/KoenageScore.txt", text);
  }
}
