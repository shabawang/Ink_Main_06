class backRoot {
  ArrayList Rs;
  boolean growState;
  float alpha;
  float timeAlpha, decA;
  backRoot(float x, float y, float a, float R, float enterAlpha, float enterDecA) {
    alpha = enterAlpha;
    Rs = new ArrayList();
    Rs.add(new one_root(x, y, a, R, alpha));
    growState = true;
    timeAlpha = 255;
    decA = enterDecA;
  }

  void add_Root(float initialR) {
    if (growState == true) {
      float x = ((one_root)Rs.get(Rs.size()-1)).x; 
      float y = ((one_root)Rs.get(Rs.size()-1)).y;
      float a = ((one_root)Rs.get(Rs.size()-1)).a;
      float R = ((one_root)Rs.get(Rs.size()-1)).R;
      float newPx = x + R*cos(radians(a));
      float newPy = y + R*sin(radians(a));
      if (alpha < 255) {
        alpha = alpha + 25;
        if (alpha > 255) {
          alpha = 255;
        }
      } else {
        alpha = 255;
      }
      if (R < initialR*0.5) {
        if (random(8) > 7) {
          float randomPicProportion = random(0.05, 0.2);
          int randomPicNumber = int(random(5));
          backLeafs.add(new backLeaf(x, y, randomPicProportion*initialR*0.1, randomPicNumber, decA));
        }
      } 
      if (R < initialR*0.2) {
        if (random(7) > 6) {
          float randomPicProportion = random(0.05, 0.2);
          int randomPicNumber = int(random(5));
          backLeafs.add(new backLeaf(x, y, randomPicProportion*initialR*0.1, randomPicNumber, decA));
        }
      }
      if (R < initialR*0.1) {
        growState = false;
        float randomPicProportion = random(0.1, 0.2);
        if (random(10) > 9) {
          //leafPositions.add(new PVector(x, y, randomPicProportion));
          int randomPicNumber = int(random(5));
          backLeafs.add(new backLeaf(x, y, randomPicProportion*initialR*0.1, randomPicNumber, decA));
        }
      }
      if (random(2) > 1) {
        a = a + random(3);
      } else {
        a = a - random(3);
      }
      Rs.add(new one_root(newPx, newPy, a, R*0.92, alpha));
      if (random(11)> 10) {
        if (random(2) > 1) {
          a = a + random(3, 30);
        } else {
          a = a - random(3, 30);
        }
        //Roots.add(new Root(newPx, newPy, a, R*1.2));
        backRoots.add(new backRoot(newPx, newPy, a, R*1.15, alpha, decA));
      }
    }
  }

  void draw_Root(PGraphics P, boolean showState) {
    for (int i = 0; i < Rs.size()-1; i++) {
      float x1 = ((one_root)Rs.get(i)).x;
      float y1 = ((one_root)Rs.get(i)).y;
      float x2 = ((one_root)Rs.get(i+1)).x;
      float y2 = ((one_root)Rs.get(i+1)).y;
      float R = ((one_root)Rs.get(i+1)).R;
      float a = ((one_root)Rs.get(i+1)).alpha;
      if (showState == true) {
        P.strokeWeight(R*4);
        P.stroke(0, 25*(a/255)*timeAlpha/255);
        P.line(x1, y1, x2, y2);

        P.strokeWeight(R*2);
        P.stroke(0, 50*(a/255)*timeAlpha/255);
        P.line(x1, y1, x2, y2);

        P.strokeWeight(R*1.5);
        P.stroke(0, 100*(a/255)*timeAlpha/255);
        P.line(x1, y1, x2, y2);
      }

      // draw
      P.strokeWeight(R);
      P.stroke(0, a*timeAlpha/255);
      P.line(x1, y1, x2, y2);
      if (showState == true) {
        P.strokeWeight(R*0.75);
        P.stroke(150, a*timeAlpha/255);
        P.line(x1, y1, x2, y2);
        P.strokeWeight(R*0.5);
        P.stroke(255, a*timeAlpha/255);
        P.line(x1, y1, x2, y2);
      }
    }
    if (timeAlpha > 0) {
      timeAlpha = timeAlpha - decA;
      if (timeAlpha < 0) {
        timeAlpha = 0;
      }
    } else {
      timeAlpha = 0;
    }
  }
  boolean getGrowState() {
    return growState;
  }
  int getRootNumber() {
    return Rs.size();
  }
  float getMinPy() {
    float minPy = ((one_root)Rs.get(0)).y;
    for (int i = 1; i < Rs.size(); i++) {
      if (minPy > ((one_root)Rs.get(i)).y) {
        minPy = ((one_root)Rs.get(i)).y;
      }
    }
    return minPy;
  }
  float getMaxPy() {
    float maxPy = ((one_root)Rs.get(0)).y;
    for (int i = 1; i < Rs.size(); i++) {
      if (maxPy < ((one_root)Rs.get(i)).y) {
        maxPy = ((one_root)Rs.get(i)).y;
      }
    }
    return maxPy;
  }
}

class one_root {
  float x, y, a, R, alpha;
  one_root(float enterX, float enterY, float enterA, float enterR, 
    float enterAlpha) {
    x = enterX;
    y = enterY;
    a = enterA;
    R = enterR;
    alpha = enterAlpha;
  }
}

class backLeaf {
  float x, y, proportion;
  int picNumber;
  float alpha, decAlpha;

  backLeaf(float enterX, float enterY, float enterProportion, int i, float enterDec) {
    x = enterX;
    y = enterY;
    proportion = enterProportion;
    picNumber = i;
    alpha = 255;
    decAlpha = enterDec;
  }
  void drawLeaf(PImage [] images, PGraphics P) {
    P.imageMode(CENTER);
    P.tint(255, alpha);
    P.image(images[picNumber], x, y, 
      (images[picNumber].width)*proportion, 
      (images[picNumber].height)*proportion);
    if (alpha > 0) {
      alpha = alpha - decAlpha;
      if (alpha < 0) {
        alpha = 0;
      }
    } else {
      alpha = 0;
    }
  }
}

class frontRoot {
  ArrayList Rs;
  boolean growState;
  float alpha;
  float timeAlpha, decA;
  frontRoot(float x, float y, float a, float R, float enterAlpha, float enterDecA) {
    alpha = enterAlpha;
    Rs = new ArrayList();
    Rs.add(new one_root(x, y, a, R, alpha));
    growState = true;
    timeAlpha = 255;
    decA = enterDecA;
  }

  void add_Root(float initialR) {
    if (growState == true) {
      float x = ((one_root)Rs.get(Rs.size()-1)).x; 
      float y = ((one_root)Rs.get(Rs.size()-1)).y;
      float a = ((one_root)Rs.get(Rs.size()-1)).a;
      float R = ((one_root)Rs.get(Rs.size()-1)).R;
      float newPx = x + R*cos(radians(a));
      float newPy = y + R*sin(radians(a));
      if (alpha < 255) {
        alpha = alpha + 25;
        if (alpha > 255) {
          alpha = 255;
        }
      } else {
        alpha = 255;
      }
      if (R < initialR*0.5) {
        if (random(8) > 7) {
          float randomPicProportion = random(0.1, 0.3);
          int randomPicNumber = int(random(5));
          frontLeafs.add(new frontLeaf(x, y, randomPicProportion*initialR*0.1, randomPicNumber, decA));
        }
      } 
      if (R < initialR*0.2) {
        if (random(7) > 6) {
          float randomPicProportion = random(0.1, 0.3);
          int randomPicNumber = int(random(5));
          frontLeafs.add(new frontLeaf(x, y, randomPicProportion*initialR*0.1, randomPicNumber, decA));
        }
      }
      if (R < initialR*0.1) {
        growState = false;
        float randomPicProportion = random(0.2, 0.3);
        if (random(10) > 9) {
          //leafPositions.add(new PVector(x, y, randomPicProportion));
          int randomPicNumber = int(random(5));
          frontLeafs.add(new frontLeaf(x, y, randomPicProportion*initialR*0.1, randomPicNumber, decA));
        }
      }
      if (random(2) > 1) {
        a = a + random(3);
      } else {
        a = a - random(3);
      }
      Rs.add(new one_root(newPx, newPy, a, R*0.92, alpha));
      if (random(13)> 12) {
        if (random(2) > 1) {
          a = a + random(3, 30);
        } else {
          a = a - random(3, 30);
        }
        //Roots.add(new Root(newPx, newPy, a, R*1.2));
        frontRoots.add(new frontRoot(newPx, newPy, a, R*1.15, alpha, decA));
      }
    }
  }

  void draw_Root(PGraphics P, boolean showState) {
    for (int i = 0; i < Rs.size()-1; i++) {
      float x1 = ((one_root)Rs.get(i)).x;
      float y1 = ((one_root)Rs.get(i)).y;
      float x2 = ((one_root)Rs.get(i+1)).x;
      float y2 = ((one_root)Rs.get(i+1)).y;
      float R = ((one_root)Rs.get(i+1)).R;
      float a = ((one_root)Rs.get(i+1)).alpha;
      if (showState == true) {
        P.strokeWeight(R*1.25);
        P.stroke(0, 100*(a/255)*timeAlpha/255);
        P.line(x1, y1, x2, y2);
      }

      // draw
      P.strokeWeight(R);
      P.stroke(0, a*timeAlpha/255);
      P.line(x1, y1, x2, y2);
      if (showState == true) {
        P.strokeWeight(R*0.75);
        P.stroke(150, a*timeAlpha/255);
        P.line(x1, y1, x2, y2);
        P.strokeWeight(R*0.5);
        P.stroke(255, a*timeAlpha/255);
        P.line(x1, y1, x2, y2);
      }
    }
    if (timeAlpha > 0) {
      timeAlpha = timeAlpha - decA;
      if (timeAlpha < 0) {
        timeAlpha = 0;
      }
    } else {
      timeAlpha = 0;
    }
  }
  boolean getGrowState() {
    return growState;
  }
  int getRootNumber() {
    return Rs.size();
  }
  float getMinPy() {
    float minPy = ((one_root)Rs.get(0)).y;
    for (int i = 1; i < Rs.size(); i++) {
      if (minPy > ((one_root)Rs.get(i)).y) {
        minPy = ((one_root)Rs.get(i)).y;
      }
    }
    return minPy;
  }
  float getMaxPy() {
    float maxPy = ((one_root)Rs.get(0)).y;
    for (int i = 1; i < Rs.size(); i++) {
      if (maxPy < ((one_root)Rs.get(i)).y) {
        maxPy = ((one_root)Rs.get(i)).y;
      }
    }
    return maxPy;
  }
}

class frontLeaf {
  float x, y, proportion;
  int picNumber;
  float alpha, decA;
  frontLeaf(float enterX, float enterY, float enterProportion, int i, float enterDec) {
    x = enterX;
    y = enterY;
    proportion = enterProportion;
    picNumber = i;
    alpha = 255;
    decA = enterDec;
  }
  void drawLeaf(PImage [] images, PGraphics P) {
    P.imageMode(CENTER);
    P.tint(255, alpha);
    P.image(images[picNumber], x, y, 
      (images[picNumber].width)*proportion, 
      (images[picNumber].height)*proportion);
    if (alpha > 0) {
      alpha = alpha - decA;
      if (alpha < 0) {
        alpha = 0;
      }
    } else {
      alpha = 0;
    }
  }
}
void generateBackTree(float initialRandom, float px, float py, float initial_a, float decA) {
  float initialR = random(initialRandom*0.86, initialRandom*1.1);
  backRoots.add(new backRoot(px, py, initial_a, initialR, 5, decA));
  for (;; ) {
    boolean allGrowState = false;
    for (int i = 0; i < backRoots.size(); i++) {
      ((backRoot)backRoots.get(i)).add_Root(initialR);
    }
    for (int i = 0; i < backRoots.size(); i++) {
      if (((backRoot)backRoots.get(i)).getGrowState() == true) {
        allGrowState = true;
      }
    }
    if (allGrowState == false) {
      break;
    }
  }
}

void generateFrontTree(float initialRandom, float px, float py, float initial_a, float decA) {
  float initialR = random(initialRandom*0.86, initialRandom*1.1);
  frontRoots.add(new frontRoot(px, py, initial_a, initialR, 5, decA));
  for (;; ) {
    boolean allGrowState = false;
    for (int i = 0; i < frontRoots.size(); i++) {
      ((frontRoot)frontRoots.get(i)).add_Root(initialR);
    }
    for (int i = 0; i < frontRoots.size(); i++) {
      if (((frontRoot)frontRoots.get(i)).getGrowState() == true) {
        allGrowState = true;
      }
    }
    if (allGrowState == false) {
      break;
    }
  }
}

void drawBackTree(PImage [] leafImages, PGraphics P, boolean showState) {
  for (int i = 0; i < backRoots.size(); i++) {
    ((backRoot)backRoots.get(i)).draw_Root(P, showState);
  }
  for (int i = 0; i < backLeafs.size(); i++) {
    ((backLeaf)backLeafs.get(i)).drawLeaf(leafImages, P);
  }
}

void drawFrontTree(PImage [] leafImages, PGraphics P, boolean showState) {
  for (int i = 0; i < frontRoots.size(); i++) {
    ((frontRoot)frontRoots.get(i)).draw_Root(P, showState);
  }
  for (int i = 0; i < frontLeafs.size(); i++) {
    ((frontLeaf)frontLeafs.get(i)).drawLeaf(leafImages, P);
  }
}
