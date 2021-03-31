class BubbleSortRunner extends Runner {
  
  public BubbleSortRunner(ArrayAccessor arr) {
    super(arr);
  }
  
  void sort() {
    
    int numSwaps = -1;
    for (int currentStep = 0; currentStep < arr.length - 1 && numSwaps != 0; currentStep++) {
      numSwaps = 0;
      for (int i = 0; i < arr.length - currentStep - 1; i++) {
        if (arr.compare(i, i + 1) > 0) {
          arr.swap(i, i + 1);
          numSwaps++;
        }
        drawAndDelay(1);
      }
    }
    
  }
  
}
