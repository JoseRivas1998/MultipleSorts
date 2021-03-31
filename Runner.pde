abstract class Runner {

  final ArrayAccessor arr;

  public Runner(ArrayAccessor arr) {
    this.arr = arr;
  }

  abstract void sort();

  void sortAndVerify() {
    this.sort();
    this.verifySorted();
  }

  void verifySorted() {
    for (int i = 0; i < arr.length; i++) {
      arr.checkRelativelySorted(i);
      drawAndDelay(1);
    }
    drawAndDelay(1);
  }
}
