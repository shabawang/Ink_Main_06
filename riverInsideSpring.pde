class riverInsideSpring {
  float cPx, cPy, springH, springW;
  int strokeAlpha, strokeColor;
  int springNumber;
  int springStrokeWeight;
  float alpha, alphaDec;

  riverInsideSpring(float enterPx, float enterPy, float enterW, float enterH, 
    float enterDec   ) {
    cPx = enterPx;
    cPy = enterPy;
    springW = enterW;
    springH = enterH;
    springNumber = int(random(2, 5));
    strokeAlpha = int(random(4, 9));
    strokeColor = int(random(220, 253));
    springStrokeWeight = int(random(1, 4));
    alpha = 255;
    alphaDec = enterDec;
  }

  void resetRiverInsideSpring(float enterPx, float enterPy, float enterW, float enterH, float enterDec ) {
    cPx = enterPx;
    cPy = enterPy;
    springW = enterW;
    springH = enterH;
    springNumber = int(random(2, 5));
    strokeAlpha = int(random(4, 9));
    strokeColor = int(random(220, 253));
    springStrokeWeight = int(random(1, 4));
    alphaDec = enterDec;
  }

  void drawSpring(float enterAlpha) {
    if (alpha > 0) {
      alpha = alpha - alphaDec;
      if (alpha < 0) {
        alpha = 0;
      }
    } else {
      alpha = 0;
    }
    noFill();
    strokeWeight(springStrokeWeight);
    beginShape();
    stroke(strokeColor, 0);
    vertex(cPx, cPy-springH*springNumber*2);
    for (int i = 0; i < springNumber; i++) {
      stroke(strokeColor, strokeAlpha*(i*2+1)*(alpha/255.)*enterAlpha);
      bezierVertex(
        cPx+springW, cPy-springH*springNumber*2+springH*2*i, 
        cPx+springW, cPy-springH*springNumber*2+springH*(2*i+1), 
        cPx, cPy-springH*springNumber*2+springH*(2*i+1));
      stroke(strokeColor, strokeAlpha*(i*2+2)*(alpha/255.)*enterAlpha);
      bezierVertex(
        cPx-springW, cPy-springH*springNumber*2+springH*(2*i+1), 
        cPx-springW, cPy-springH*springNumber*2+springH*(2*i+2), 
        cPx, cPy-springH*springNumber*2+springH*(2*i+2));
    }
    for (int i = 0; i < springNumber; i++) {
      stroke(strokeColor, strokeAlpha*springNumber*2-strokeAlpha*(i*2+1)*(alpha/255.));
      bezierVertex(
        cPx+springW, cPy-springH*springNumber*2+springH*2*i+springH*springNumber*2, 
        cPx+springW, cPy-springH*springNumber*2+springH*(2*i+1)+springH*springNumber*2, 
        cPx, cPy-springH*springNumber*2+springH*(2*i+1)+springH*springNumber*2);
      stroke(strokeColor, strokeAlpha*springNumber*2-strokeAlpha*(i*2+2)*(alpha/255.)*enterAlpha);
      bezierVertex(
        cPx-springW, cPy-springH*springNumber*2+springH*(2*i+1)+springH*springNumber*2, 
        cPx-springW, cPy-springH*springNumber*2+springH*(2*i+2)+springH*springNumber*2, 
        cPx, cPy-springH*springNumber*2+springH*(2*i+2)+springH*springNumber*2);
    }
    endShape();
  }
}
