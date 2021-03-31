class CountingSortRunner extends Runner {

  public CountingSortRunner(ArrayAccessor arr) {
    super(arr);
  }

  public void sort() {
    final int maxValue = this.maxValue();
    int[] occurances = new int[maxValue + 1];
    for (int i = 0; i < this.arr.length; i++) {
      occurances[this.arr.get(i)]++;
      drawAndDelay(1);
    }
    drawAndDelay(1);
    int insertIndex = 0;
    for (int i = 0; i < occurances.length; i++) {
      for (int n = 0; n < occurances[i]; n++) {
        this.arr.set(insertIndex++, i);
        drawAndDelay(1);
      }
      drawAndDelay(1);
    }
    drawAndDelay(1);
  }

  int maxValue() {
    int maxValue = this.arr.get(0);
    for (int i = 1; i < this.arr.length; i++) {
      maxValue = max(this.arr.get(i), maxValue);
      drawAndDelay(1);
    }
    drawAndDelay(1);
    return maxValue;
  }
}
