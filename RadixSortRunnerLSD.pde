public abstract class RadixSortRunnerLSD extends Runner {
  
  final int base;
  
  public RadixSortRunnerLSD(ArrayAccessor arr, int base) {
    super(arr);
    this.base = base;
  }
  
  void sort() {
    final int numPasses = this.numPasses();
    final Bucket[] buckets = new Bucket[base];
    for (int i = 0; i < buckets.length; i++) {
      buckets[i] = new Bucket();
    }
    
    int currentRadix = 1;
    for (int pass = 0; pass < numPasses; pass++) {
      
      for (int i = 0; i < this.arr.length; i++) {
        final int val = this.arr.get(i);
        final int bucketIndex = (val / currentRadix) % this.base;
        buckets[bucketIndex].add(val);
        drawAndDelay(1);
      }
      
      int insertIndex = 0;
      
      for (int i = 0; i < buckets.length; i++) {
        Bucket bucket = buckets[i];
        for (Node currentNode = bucket.head; currentNode != null; currentNode = currentNode.next) {
          this.arr.set(insertIndex++, currentNode.data);
        drawAndDelay(1);
        }
        bucket.clear();
      }
      
      currentRadix *= this.base;
      drawAndDelay(1);
    }
  }
  
  int numPasses() {
    final int max = maxValue();
    return floor(log(max) / log(this.base)) + 1;
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
  
  private class Node {
    
    final int data;
    Node next;
    
    Node(int data, Node next) {
      this.data = data;
      this.next = next;
    }
    
    Node(int data) {
      this(data, null);
    }
    
  }
  
  private class Bucket {
    
    Node head = null;
    Node tail = null;
    
    void add(int data) {
      Node newNode = new Node(data);
      if (head == null) {
        this.head = newNode;
        this.tail = newNode;
      } else {
        this.tail.next = newNode;
        this.tail = newNode;
      }
    }
    
    void clear() {
      this.head = null;
      this.tail = null;
    }
    
  }
  
}

public class RadixSortRunnerLSDBase4 extends RadixSortRunnerLSD {
  
  public RadixSortRunnerLSDBase4(ArrayAccessor arr) {
    super(arr, 4);
  }
  
}

public class RadixSortRunnerLSDBase10 extends RadixSortRunnerLSD {
  
  public RadixSortRunnerLSDBase10(ArrayAccessor arr) {
    super(arr, 10);
  }
  
}
