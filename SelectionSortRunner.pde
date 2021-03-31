class SelectionSortRunner extends Runner {
  
  public SelectionSortRunner(ArrayAccessor arr) {
    super(arr);
  }
  
  void sort() {
    
    for (int i = 0; i < arr.length - 1; i++) {
      this.arr.swap(i, minIndex(i));
      drawAndDelay(1);
    }
    
  }
  
  private int minIndex(int start) {
    
    int minIndex = start;
    for (int i = minIndex + 1; i < this.arr.length; i++) {
      if (arr.compare(i, minIndex) < 0) {
        minIndex = i;
      }
      drawAndDelay(1);
    }
    return minIndex;
    
  }
  
}
