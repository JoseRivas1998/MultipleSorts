class MinHeapSortRunner extends Runner {
  
  int heapSize;
  
  public MinHeapSortRunner(ArrayAccessor arr) {
    super(arr);
    this.heapSize = this.arr.length;
  }
  
  void sort() {
    buildMinHeap();
    while(this.heapSize > 0) {
      extractMin();
    }
    for (int i = 0; i < this.arr.length / 2; i++) {
      this.arr.swap(i, this.arr.length - 1 - i);
      drawAndDelay(1);
    }
  }
  
  void buildMinHeap() {
    for (int i = heapSize / 2; i >= 0; i--) {
      this.minHeapify(i);
    }
  }
  
  void minHeapify(int i) {
    final int l = left(i);
    final int r = right(i);
    int smallest = i;
    if (l < this.heapSize && this.arr.compare(l, i) < 0) {
      smallest = l;
    }
    if (r < this.heapSize && this.arr.compare(r, smallest) < 0) {
      smallest = r;
    }
    if (smallest != i) {
      this.arr.swap(i, smallest);
      drawAndDelay(1);
      minHeapify(smallest);
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
  
  void extractMin() {
    this.arr.swap(0, this.heapSize - 1);
    this.heapSize--;
    minHeapify(0);
  }
  
}
