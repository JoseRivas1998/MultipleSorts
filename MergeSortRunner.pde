class MergeSortRunner extends Runner {

  public MergeSortRunner(ArrayAccessor arr) {
    super(arr);
  }

  void sort() {
    mergeSort(0, this.arr.length - 1);
  }

  void mergeSort(int start, int end) {
    if (start >= end) return;

    final int mid = start + (end - start) / 2;

    mergeSort(start, mid);
    mergeSort(mid + 1, end);
    merge(start, mid, end);
  }

  void merge(int start, int mid, int end) {

    int[] left = this.arr.copy(start, mid - start + 1);
    int[] right = this.arr.copy(mid + 1, end - mid);

    int leftIndex = 0;
    int rightIndex = 0;
    int arrayIndex = start;
    while (leftIndex < left.length && rightIndex < right.length) {
      if (this.arr.compareValues(left[leftIndex], right[rightIndex]) < 0) {
        arr.set(arrayIndex++, left[leftIndex++]);
      } else {
        arr.set(arrayIndex++, right[rightIndex++]);
      }
      drawAndDelay(1);
    }
    while (leftIndex < left.length) {
      arr.set(arrayIndex++, left[leftIndex++]);
      drawAndDelay(1);
    }
    while (rightIndex < right.length) {
      arr.set(arrayIndex++, right[rightIndex++]);
      drawAndDelay(1);
    }
  }
}
