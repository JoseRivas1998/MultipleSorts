import java.util.Set;
import java.util.HashSet;
import java.util.Queue;
import java.util.ArrayDeque;

enum Visualizer {
  BARS, COLOR_CIRCLE
}

class ArrayAccessor {

  private final int[] arr;
  public final int length;

  private int reads;
  private int writes;
  private int comparisons;
  private int swaps;

  private final Set<Integer> accessed;
  private final Set<Integer> sorted;

  private int min;
  private int max;

  private Visualizer visualizer;
  private Queue<Visualizer> visualizerQueue;

  private final SinOsc sine;

  public ArrayAccessor(int length) {
    this.length = length;
    this.arr = new int[this.length];
    this.min = Integer.MAX_VALUE;
    this.max = Integer.MIN_VALUE;
    this.accessed = new HashSet<Integer>();
    this.sorted = new HashSet<Integer>();
    this.visualizerQueue = new ArrayDeque<Visualizer>();
    this.nextVisualizer();
    this.reset();
    this.sine = new SinOsc(MultipleSorts.this);
  }

  public void reset() {
    this.reads = 0;
    this.writes = 0;
    this.comparisons = 0;
    this.accessed.clear();
    this.sorted.clear();
  }

  public int getReads() {
    return this.reads;
  }

  public int getWrites() {
    return this.writes;
  }

  public int getComparisons() {
    return this.comparisons;
  }

  public int getSwaps() {
    return this.swaps;
  }

  public int get(int i) {
    this.reads++;
    this.accessed.add(i);
    return this.arr[i];
  }

  public void set(int i, int v) {
    this.writes++;
    this.accessed.add(i);
    this.min = min(min, v);
    this.max = max(max, v);
    this.arr[i] = v;
  }

  public int compare(int i, int j) {
    this.comparisons++;
    return this.get(i) - this.get(j);
  }

  public int compareIndexWithValue(int i, int v) {
    this.comparisons++;
    return this.get(i) - v;
  }

  public int compareValues(int a, int b) {
    this.comparisons++;
    return a - b;
  }

  public void swap(int i, int j) {
    this.swaps++;
    final int temp = this.get(i);
    this.set(i, this.get(j));
    this.set(j, temp);
  }

  public void nextVisualizer() {
    Visualizer nextVisualizer;
    if (this.visualizer == null) {
      nextVisualizer = Visualizer.BARS;
    } else {
      final Visualizer[] visualizers = Visualizer.values();
      int nextIndex = (this.visualizer.ordinal() + 1) % visualizers.length;
      nextVisualizer = visualizers[nextIndex];
    }
    this.visualizerQueue.add(nextVisualizer);
  }

  public void prevVisualizer() {
    Visualizer nextVisualizer;
    if (this.visualizer == null) {
      nextVisualizer = Visualizer.BARS;
    } else {
      final Visualizer[] visualizers = Visualizer.values();
      int nextIndex = (this.visualizer.ordinal() + visualizers.length - 1) % visualizers.length;
      nextVisualizer = visualizers[nextIndex];
    }
    this.visualizerQueue.add(nextVisualizer);
  }

  public void display() {
    this.sine.stop();
    Visualizer nextVisualizer = this.visualizerQueue.poll();
    if (nextVisualizer != null) {
      this.visualizer = nextVisualizer;
    }
    switch (this.visualizer) {
    case BARS:
      this.displayAsBars();
      break;
    case COLOR_CIRCLE:
      this.displayAsColorCircle();
      break;
    }
    this.accessed.clear();
  }

  private void displayAsBars() {
    colorMode(RGB, 255);
    stroke(0);
    strokeWeight(1);
    final float barWidth = (float) width / this.arr.length;
    for (int i = 0; i < this.arr.length; i++) {
      final float barHeight = map(this.arr[i], min, max, 20, height - 20);
      final float x = i * barWidth;
      final float y = height - barHeight;
      if (this.accessed.contains(i)) {
        fill(255, 0, 0);
        this.playIndex(i);
      } else if (this.sorted.contains(i)) {
        fill(0, 255, 0);
      } else {
        fill(255);
      }
      rect(x, y, barWidth, barHeight);
    }
  }

  private void displayAsColorCircle() {
    pushMatrix();
    translate(width / 2, height / 2);
    rotate(-HALF_PI);
    colorMode(HSB, 360, 100, 100);
    final float radius = min(width / 2 - 20, height / 2 - 20);
    for (int i = 0; i < this.arr.length; i++) {
      if (this.accessed.contains(i)) {
        strokeWeight(5);
        stroke(0, 0, 0);
        this.playIndex(i);
      } else {
        noStroke();
      }
      fill(map(barHeights.get(i), min, max, 0, 360), 100, 100);
      beginShape();
      final float theta = map(i, 0, this.length, 0, TWO_PI);
      final float nextTheta = map(i + 1, 0, this.length, 0, TWO_PI);
      final float x1 = radius * cos(theta);
      final float y1 = radius * sin(theta);
      final float x2 = radius * cos(nextTheta);
      final float y2 = radius * sin(nextTheta);
      vertex(0, 0, x1, y1);
      vertex(x1, y1, x2, y2);
      vertex(x2, y2, 0, 0);
      endShape();
    }
    popMatrix();
  }

  private void playIndex(int i) {
    this.sine.stop();
    this.sine.play(map(this.arr[i], min, max, 250, 1500), 0.);
  }

  public int[] copy(int start, int copyLength) {
    int[] cpy = new int[copyLength];
    System.arraycopy(this.arr, start, cpy, 0, copyLength);
    return cpy;
  }

  public void checkRelativelySorted(int i) {
    if (this.length <= 1) {
      this.sorted.add(i);
    } else if (i == 0 && this.compare(i, i + 1) <= 0) {
      this.sorted.add(i);
    } else if (i == this.length - 1 && this.compare(i, i - 1) >= 0) {
      this.sorted.add(i);
    } else if (this.compare(i, i + 1) <= 0 && this.compare(i, i - 1) >= 0) {
      this.sorted.add(i);
    }
  }
}
