// 2次元ベクトルクラス
public class Vec2 {
  float x, y;

  public Vec2(float _x, float _y) {
    x = _x;
    y = _y;
  }

  // ベクトル同士の足し算
  public Vec2 add(Vec2 v) {
    Vec2 n = new Vec2(x + v.x, y + v.y);
    return n;
  }

  // かけ算
  public Vec2 mult(int s) {
    Vec2 n = new Vec2(s*x, s*y);
    return n;
  }
}
