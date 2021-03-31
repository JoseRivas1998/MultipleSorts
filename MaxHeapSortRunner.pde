class MaxHeapSortRunner extends Runner {
  
  int heapSize;
  
  public MaxHeapSortRunner(ArrayAccessor arr) {
    super(arr);
    this.heapSize = this.arr.length;
  }
  
  void sort() {
    buildMaxHeap();
    while(this.heapSize > 0) {
      extractMax();
    }
  }
  
  void buildMaxHeap() {
    for (int i = heapSize / 2; i >= 0; i--) {
      this.maxHeapify(i);
    }
  }
  
  void maxHeapify(int i) {
    final int l = left(i);
    final int r = right(i);
    int largest = i;
    if (l < this.heapSize && this.arr.compare(l, i) > 0) {
      largest = l;
    }
    if (r < this.heapSize && this.arr.compare(r, largest) > 0) {
      largest = r;
    }
    if (largest != i) {
      this.arr.swap(i, largest);
      drawAndDelay(1);
      maxHeapify(largest);
    }
  }
  
  int parent(int i) {
    return max(0, i - 1 / 2);
  }
  
  int left(int i) {
    return 2 * i + 1;
  }
  
  int right(int i) {
    return 2 * i + 2;
  }
  
  void extractMax() {
    this.arr.swap(0, this.heapSize - 1);
    this.heapSize--;
    maxHeapify(0);
  }
  
}
