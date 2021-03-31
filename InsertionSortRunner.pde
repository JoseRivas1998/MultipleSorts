class InsertionSortRunner extends Runner {

  public InsertionSortRunner(ArrayAccessor arr) {
    super(arr);
  }

  void sort() {
    for (int currentStep = 1; currentStep < arr.length; currentStep++) {
      int insertionIndex = currentStep;
      while (insertionIndex > 0 && arr.compare(insertionIndex, insertionIndex - 1) < 0) {
        this.arr.swap(insertionIndex, --insertionIndex);
        drawAndDelay(1);
      }
      drawAndDelay(1);
    }
  }
}
