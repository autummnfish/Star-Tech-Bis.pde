public class FuturePoint {
  private PVector force;
  private PVector acceleration;
  private PVector location;
  private PVector velocity;
  private float mass;
  private int dir = 3;

  public FuturePoint(int x, int weight) {
    this.velocity = new PVector(0, 0);
    this.force = new PVector(0, random(5)-2.5);
    if (force.y < 0) location = new PVector(x, height);
    else location = new PVector(x, 0);
    this.mass = weight;
    acceleration = force.mult(mass);
  }

  public void Draw() {
    //velocity.add(acceleration);
    //location.add(velocity);
    //acceleration.set(0, 0);
    ellipse(location.x, location.y, dir, dir);
  }

  public void Update() {
    if (location.y > height) {
      location.y = 0;
      force.set(0, random(5)-2.5);
      acceleration = force.mult(mass);
    } else if (location.y < 0) {
      location.y = height;
      force.set(0, random(5)-2.5);
      acceleration = force.mult(mass);
    }
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.set(0, 0);
  }
}
