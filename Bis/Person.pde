// 人の描画
public class Person {
  private PVector head;
  private int size = 100;
  private PVector body;
  private int wide = 20;
  private color personColor = color(#818dff);
  Person(float x, float y) {
    head = new PVector(x, y);
    body = new PVector(x, 5 * y / 4);
  }

  public void Draw() {
    fill(personColor);
    ellipse(body.x, body.y, size + wide, (body.y - head.y)*2);
    ellipse(head.x, head.y, size, size);
  }
  
  public PVector GetHeadPosition() {
    return head;
  }
}
