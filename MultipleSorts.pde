import processing.sound.*; //<>//

import java.lang.reflect.Constructor;

ArrayAccessor barHeights;

boolean started = false;
boolean shuffling = false;
enum Runners {
  BUBBLE("Bubble Sort", BubbleSortRunner.class), 
    SELECTION("Selection Sort", SelectionSortRunner.class), 
    INSERTION("Insertion Sort", InsertionSortRunner.class), 
    MAX_HEAP("Max Heap Sort", MaxHeapSortRunner.class), 
    MIN_HEAP("Min Heap Sort", MinHeapSortRunner.class), 
    MERGE("Merge Sort", MergeSortRunner.class), 
    QUICK("Quick Sort", QuickSortRunner.class), 
    COUNT("Counting Sort", CountingSortRunner.class),
    RADIX_LSD_4("Radix Sort Base 4 (LSD)", RadixSortRunnerLSDBase4.class),
    RADIX_LSD_10("Radix Sort Base 10 (LSD)", RadixSortRunnerLSDBase10.class)
    ;
  final String name;
  final Class<? extends Runner> clazz;
  private Runners(String name, Class<? extends Runner> clazz) {
    this.name = name;
    this.clazz = clazz;
  }
}

Runners runner;

boolean drawAsBars = true;

void setup() {
  size(1920, 1080, P2D);
  //fullScreen(P2D, 3);
  runner = Runners.values()[0];
  barHeights = initializeArray(256);
  noLoop();
}

void keyPressed() {
  if (keyCode == RIGHT) {
    this.barHeights.nextVisualizer();
    drawAndDelay(1);
  } else if (keyCode == LEFT) {
    this.barHeights.prevVisualizer();
    drawAndDelay(1);
  } else if (!started) {
    if (keyCode == UP) {
      runner = Runners.values()[(runner.ordinal() + 1) % Runners.values().length];
      drawAndDelay(1);
    } else if (keyCode == DOWN) {
      runner = Runners.values()[(runner.ordinal() + Runners.values().length - 1) % Runners.values().length];
      drawAndDelay(1);
    } else if(key == '.') {
      barHeights = initializeArray(max(1, barHeights.length / 2));
      drawAndDelay(1);
    } else if(key == ',') {
      barHeights = initializeArray(barHeights.length * 2);
      drawAndDelay(1);
    } else {
      final Class thisClass = this.getClass();
      final Object thisObj = this;
      new Thread(new Runnable() {
        @Override
          public void run() {
          //new HeapSortRunner(barHeights).sort();
          try {
            barHeights.reset();
            shuffling = true;
            shuffleArray(barHeights, 2);
            drawAndDelay(30);
            shuffling = false;
            Runner sortRunner = (Runner) runner.clazz.getConstructor(new Class[]{thisClass, ArrayAccessor.class}).newInstance(thisObj, barHeights);
            sortRunner.sortAndVerify();
            started = false;
          } 
          catch(Exception e) {
            throw new RuntimeException(e);
          }

          drawAndDelay(1);
          drawAndDelay(1);
        }
      }
      ).start();
      started = true;
    }
  }
}

void draw() {
  background(0);
  colorMode(RGB, 255);
  stroke(0);
  fill(255);
  textSize(48);
  text(started ? (shuffling ? "Shuffling" : "Sorting") : runner.name, 25, 50);
  barHeights.display();
}

ArrayAccessor initializeArray(int numBars) {
  ArrayAccessor arr = new ArrayAccessor(numBars);
  for (int i = 0; i  < arr.length; i++) {
    arr.set(i, i);
  }
  arr.reset();
  return arr;
}

void reverseArray(ArrayAccessor arr) {
  for (int i = 0; i < arr.length / 2; i++) {
    arr.swap(i, arr.length - 1 - i);
    drawAndDelay(1);
  }
}

void shuffleArray(ArrayAccessor arr, int passes) {
  for (int pass = 0; pass < passes; pass++) {
    for (int i = pass % 2 == 0 ? 0 : arr.length - 1; i < arr.length && i >= 0; i += (pass % 2 == 0 ? 1 : -1)) {
      int j = floor(random(arr.length));
      arr.swap(i, j);
      drawAndDelay(1);
    }
  }
  drawAndDelay(1);
}

void drawAndDelay(int frames) {
  final long startTime = System.currentTimeMillis();
  final long delayTime = 1000/120 * frames;
  synchronized(this) {
    redraw();
    final long waitTime = System.currentTimeMillis() - startTime;
    final long sleepTime = delayTime - waitTime > 0 ? delayTime - waitTime : 0;
    try {
      Thread.sleep(sleepTime);
    } 
    catch(Exception e) {
    }
  }
}
