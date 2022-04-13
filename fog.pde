class fog {
  float x, y, proportionSize;
  int imageNumber, colorAlpha;
  float alpha, alphaDec;

  fog(float enterX, float enterY, int number, float enterDec) {
    x = enterX;
    y = enterY;
    proportionSize = random(0.5, 1);
    imageNumber = number;
    colorAlpha = int(random(8, 40));
    alpha = 255;
    alphaDec = enterDec;
  }
  void drawFog(PImage [] P) {
    if (alpha > 0) {
      alpha = alpha - alphaDec;
      if (alpha < 0) {
        alpha = 0;
      }
    } else {
      alpha = 0;
    }
    imageMode(CENTER);
    tint(255, colorAlpha*(alpha/255));
    image(P[imageNumber], x, y, 
      P[imageNumber].width*proportionSize, 
      P[imageNumber].height*proportionSize);
  }
  float getFogSize() {
    return 200*proportionSize;
  }
}

class avoidPoint {
  float x, y, D;
  float alpha, alphaDec;
  avoidPoint(float enterX, float enterY, float enterD, float enterAlpha, float enterDec) {
    x = enterX;
    y = enterY;
    D = enterD;
    alpha = enterAlpha;
    alphaDec = enterDec;
  }
  void updatePoint() {
    if (alpha > 0) {
      alpha = alpha - alphaDec;
      if (alpha < 0) {
        alpha = 0;
      }
    } else {
      alpha = 0;
    }
  }
  void drawPoint() {
    noStroke();
    fill(255, 0, 0, alpha);
    ellipse(x, y, D*2, D*2);
  }
}
class riverPoint {
  float px, py;
  int fillColor, fillAlpha;
  riverPoint(float enterX, float enterY, int enterColor, int enterAlpha) {
    px = enterX;
    py = enterY;
    fillColor = enterColor;
    fillAlpha = enterAlpha;
  }
}
