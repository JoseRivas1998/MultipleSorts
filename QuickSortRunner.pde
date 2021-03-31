class QuickSortRunner extends Runner {

  public QuickSortRunner(ArrayAccessor arr) {
    super(arr);
  }
  
  void sort() {
    quickSort(0, this.arr.length - 1);
  }
  
  void quickSort(int start, int end) {
    if (start >= end) return;
    
    int pi = partition(start, end);
    
    quickSort(start, pi - 1);
    quickSort(pi + 1, end);
    
    drawAndDelay(1);
    
  }
  
  int partition(int low, int high) {
    int pivot = this.arr.get(high);
    int i = low - 1;
    
    for (int j = low; j < high; j++) {
      if (this.arr.compareIndexWithValue(j, pivot) < 0) {
        i++;
        this.arr.swap(i, j);
        drawAndDelay(1);
      }
    }
    this.arr.swap(i + 1, high);
    drawAndDelay(1);
    return i + 1;
  }
  
}
