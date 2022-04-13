class InkRiver {
  float riverPointAlpha, riverPointAlphaDec;

  ArrayList pos;
  float px1, py1, R1, a1, px2, py2, R2, a2;
  float riverWidth, riverProportion;

  ArrayList rPLs, rPRs, rPCs;

  // riverInside
  ArrayList RISs;

  // fogs
  ArrayList fogs;

  InkRiver(float enterDec) {
    pos = new ArrayList();
    rPLs = new ArrayList();
    rPRs = new ArrayList();
    rPCs = new ArrayList();
    fogs = new ArrayList();
    riverPointAlpha = 255;
    riverPointAlphaDec = enterDec;
    riverWidth = random(50, 100);
    riverProportion = random(2, 5);
    // riverInside
    RISs = new ArrayList();
  }
  void addAvoidPos(float x, float y, float D, float alpha, float dec) {
    pos.add(new avoidPoint(x, y, D, alpha, dec));
  }
  void drawInkRiver() {

    for (int i = 0; i < pos.size(); i++) {
      ((avoidPoint)pos.get(i)).updatePoint();
    }
    for (int i = 0; i < pos.size(); i++) {
      if (((avoidPoint)pos.get(i)).alpha == 0) {
        pos.remove(i);
      }
    }
    if (riverPointAlpha > 0) {
      riverPointAlpha = riverPointAlpha - riverPointAlphaDec;
      if (riverPointAlpha < 0) {
        riverPointAlpha = 0;
      }
    } else {
      riverPointAlpha = 0;
    }
    for (int i = 0; i < fogs.size(); i++) {
      if (((fog)fogs.get(i)).alpha == 0) {
        fogs.remove(i);
      }
    }
    for (int i = 0; i < RISs.size(); i++) {
      if (((riverInsideSpring)RISs.get(i)).alpha == 0) {
        RISs.remove(i);
      }
    }
    if (riverPointAlpha > 0) {
      drawRiver();
    }
    for (int i = 0; i < fogs.size(); i++) {
      ((fog)fogs.get(i)).drawFog(imageFogs);
    }
    for (int i = 0; i < RISs.size(); i++) {
      ((riverInsideSpring)RISs.get(i)).drawSpring(riverPointAlpha*0.003);
    }
  }
  void drawAvoidPos() {
    for (int i = 0; i < pos.size(); i++) {
      ((avoidPoint)pos.get(i)).drawPoint();
    }
  }
  void generateRiver() {
    if (random(2) > 1) {
      px1 = -random(width/10, width/5);
      py1 = height/2-random(height)*0.8;

      px2 = width+random(width/5, width/2);
      py2 = height/2+random(height)*0.8;
      if (random(3) > 1) {
        a1 = random(0.1);
      } else {
        a1 = -random(0.1);
      }
      R1 = random(width/3, width*1.3);
      if (random(3) > 1) {
        a2 = PI+random(0.1);
      } else {
        a2 = PI-random(0.1);
      }
      R2 = random(width/3, width*1.3);
      for (float t = 0; t <= 1; t = t + 0.05) {
        float x = bezierPoint(px1, px1+R1*cos(a1), px2+R2*cos(a2), px2, t);
        float y = bezierPoint(py1, py1+R1*sin(a1), py2+R2*sin(a2), py2, t);
        float tx = bezierTangent(px1, px1+R1*cos(a1), px2+R2*cos(a2), px2, t);
        float ty = bezierTangent(py1, py1+R1*sin(a1), py2+R2*sin(a2), py2, t);
        float a = atan2(ty, tx);
        a -= HALF_PI;
        rPCs.add(new riverPoint(x, y, 
          int(240+15*noise(t*0.01, random(100))), 
          int(50+50*noise(t*0.01, random(100)))));
        //line(x, y, cos(a)*(t*2+1)*riverWidth/2 + x, sin(a)*(t*2+1)*riverWidth/2 + y);
        rPRs.add(new riverPoint(
          cos(a)*(t*riverProportion+1)*riverWidth/2 + x, 
          sin(a)*(t*riverProportion+1)*riverWidth/2 + y, 
          int(237+16*noise(t*0.01, random(100))), 
          int(100+100*noise(t*0.01, random(100)))));
        a = a+PI;
        //line(x, y, cos(a)*(t*2+1)*riverWidth/2 + x, sin(a)*(t*2+1)*riverWidth/2 + y);
        rPLs.add(new riverPoint(
          cos(a)*(t*riverProportion+1)*riverWidth/2 + x, 
          sin(a)*(t*riverProportion+1)*riverWidth/2 + y, 
          int(237+16*noise(t*0.01, random(100))), 
          int(100+100*noise(t*0.01, random(100)))));
      }
    } else {
      px1 = width+random(width/10, width/5);
      py1 = height/2-random(height/2);

      px2 = -random(width/5, width/2);
      py2 = height/2+random(height/2);
      if (random(3) > 1) {
        a1 = PI+random(0.1);
      } else {
        a1 = PI-random(0.1);
      }
      R1 = random(width/3, width*1.3);
      if (random(3) > 1) {
        a2 = random(0.1);
      } else {
        a2 = -random(0.1);
      }
      R2 = random(width/3, width*1.3);
      for (float t = 0; t <= 1; t = t + 0.05) {
        float x = bezierPoint(px1, px1+R1*cos(a1), px2+R2*cos(a2), px2, t);
        float y = bezierPoint(py1, py1+R1*sin(a1), py2+R2*sin(a2), py2, t);
        float tx = bezierTangent(px1, px1+R1*cos(a1), px2+R2*cos(a2), px2, t);
        float ty = bezierTangent(py1, py1+R1*sin(a1), py2+R2*sin(a2), py2, t);
        float a = atan2(ty, tx);
        a -= HALF_PI;
        rPCs.add(new riverPoint(x, y, 
          int(240+15*noise(t*0.01, random(100))), 
          int(50+50*noise(t*0.01, random(100)))));
        //line(x, y, cos(a)*(t*2+1)*riverWidth/2 + x, sin(a)*(t*2+1)*riverWidth/2 + y);
        rPRs.add(new riverPoint(
          cos(a)*(t*riverProportion+1)*riverWidth/2 + x, 
          sin(a)*(t*riverProportion+1)*riverWidth/2 + y, 
          int(237+16*noise(t*0.01, random(100))), 
          int(100+100*noise(t*0.01, random(100)))));
        a = a+PI;
        //line(x, y, cos(a)*(t*2+1)*riverWidth/2 + x, sin(a)*(t*2+1)*riverWidth/2 + y);
        rPLs.add(new riverPoint(
          cos(a)*(t*riverProportion+1)*riverWidth/2 + x, 
          sin(a)*(t*riverProportion+1)*riverWidth/2 + y, 
          int(237+16*noise(t*0.01, random(100))), 
          int(100+100*noise(t*0.01, random(100)))));
      }
    }
  }
  boolean detect_touch_positions() {
    println("pos_size:"+pos.size());
    boolean touchFlag = false;
    for (int j = 0; j < pos.size(); j++) {
      float comPx = ((avoidPoint)pos.get(j)).x;
      float comPy = ((avoidPoint)pos.get(j)).y;
      float comR = ((avoidPoint)pos.get(j)).D;
      if (insideRiver(comPx, comPy, comR) == true) {
        touchFlag = true;
        break;
      }
    }
    return touchFlag;
  }
  boolean insideRiver(float x, float y, float R) {
    boolean touchFlag = false;
    for (int i = 0; i < rPCs.size(); i++) {
      float cx = ((riverPoint)rPCs.get(i)).px;
      float cy = ((riverPoint)rPCs.get(i)).py;
      if (dist(cx, cy, x, y)<R*0.8*(1+(float(i)/float(rPCs.size())*riverProportion ))) {
        touchFlag = true;
        break;
      }
    }
    return touchFlag;
  }
  void generateFogs(float enterDec) {
    float noiseSeed = random(100);
    for (int i = 0; i < width; i++) {
      for (int j = 0; j < height; j++) {
        float colorSeed = noise(i*0.01, j*0.01, noiseSeed)*255;
        if (colorSeed < 130) {
          if (random(colorSeed) < 0.1) {
            fogs.add(new fog(i, j, int(random(11)), enterDec));
          }
        }
      }
    }
    for (int i = 0; i < fogs.size(); i++) {
      float px = ((fog)fogs.get(i)).x;
      float py = ((fog)fogs.get(i)).y;
      float fogSize = ((fog)fogs.get(i)).getFogSize()*0.4;
      if (insideRiver(px, py, fogSize) == false) {
        fogs.remove(i);
        i = 0;
      }
    }
  }
  void generateRiverInsideSpring(float enterDec) {
    if (generateRightRiver() == true) {
      float noiseSeed = random(100);
      for (int i = 0; i < width; i++) {
        for (int j = 0; j < height; j++) {
          float colorSeed = noise(i*0.01, j*0.01, noiseSeed)*255;
          if (colorSeed < 130) {
            if (random(colorSeed) < 0.2) {
              RISs.add(new riverInsideSpring(i, j, 
                sqrt(j)*random(9, 25)/sqrt(height), 
                sqrt(j)*random(5, 12)/sqrt(height), 
                enterDec));
            }
          }
        }
      }
      for (int i = 0; i < RISs.size(); i++) {
        float cx = ((riverInsideSpring)RISs.get(i)).cPx;
        float cy = ((riverInsideSpring)RISs.get(i)).cPy;
        float cw = ((riverInsideSpring)RISs.get(i)).springW*3;
        if (insideRiver(cx, cy, cw) == false) {
          RISs.remove(i);
          i = 0;
        }
      }
    }
  }
  void drawRiver() {
    noStroke();
    beginShape(TRIANGLE_STRIP);
    for (int i = 0; i < rPLs.size(); i++) {
      float x1 = ((riverPoint)rPLs.get(i)).px;
      float y1 = ((riverPoint)rPLs.get(i)).py;
      int c1 = ((riverPoint)rPLs.get(i)).fillColor;
      int a1 = ((riverPoint)rPLs.get(i)).fillAlpha;
      float x2 = ((riverPoint)rPCs.get(i)).px;
      float y2 = ((riverPoint)rPCs.get(i)).py;
      int c2 = ((riverPoint)rPCs.get(i)).fillColor;
      //fill(0, 0, c1, a1*(riverPointAlpha/255.));
      //ellipse(x1, y1, 5, 5);
      //fill(c1, 0, 0, a1*(riverPointAlpha/255.));
      //ellipse(x2, y2, 5, 5);

      if ((i == 0)||(i == rPLs.size()-1)) {
        fill(c1, 0);
      } else {
        fill(c1, a1*(riverPointAlpha/255.));
      }
      vertex(x1, y1);
      fill(c2, 0);
      vertex(x1+(x1-x2)*0.5, y1+(y1-y2)*0.5);
    }
    endShape();

    beginShape(TRIANGLE_STRIP);
    for (int i = 0; i < rPLs.size(); i++) {
      float x1 = ((riverPoint)rPLs.get(i)).px;
      float y1 = ((riverPoint)rPLs.get(i)).py;
      int c1 = ((riverPoint)rPLs.get(i)).fillColor;
      int a1 = ((riverPoint)rPLs.get(i)).fillAlpha;
      float x2 = ((riverPoint)rPCs.get(i)).px;
      float y2 = ((riverPoint)rPCs.get(i)).py;
      int c2 = ((riverPoint)rPCs.get(i)).fillColor;
      int a2 = ((riverPoint)rPCs.get(i)).fillAlpha;
      //ellipse(x, y, 5, 5);
      if ((i == 0)||(i == rPLs.size()-1)) {
        fill(c1, 0);
      } else {
        fill(c1, a1*(riverPointAlpha/255.));
      }
      vertex(x1, y1);
      if ((i == 0)||(i == rPLs.size()-1)) {
        fill(c2, 0);
      } else {
        fill(c2, a2*(riverPointAlpha/255.));
      }
      vertex(x2, y2);
    }
    endShape();
    beginShape(TRIANGLE_STRIP);
    for (int i = 0; i < rPRs.size(); i++) {
      float x1 = ((riverPoint)rPRs.get(i)).px;
      float y1 = ((riverPoint)rPRs.get(i)).py;
      int c1 = ((riverPoint)rPRs.get(i)).fillColor;
      int a1 = ((riverPoint)rPRs.get(i)).fillAlpha;
      float x2 = ((riverPoint)rPCs.get(i)).px;
      float y2 = ((riverPoint)rPCs.get(i)).py;
      int c2 = ((riverPoint)rPCs.get(i)).fillColor;
      int a2 = ((riverPoint)rPCs.get(i)).fillAlpha;
      //ellipse(x, y, 5, 5);
      if ((i == 0)||(i == rPRs.size()-1)) {
        fill(c1, 0);
      } else {
        fill(c1, a1*(riverPointAlpha/255.));
      }
      vertex(x1, y1);
      if ((i == 0)||(i == rPRs.size()-1)) {
        fill(c2, 0);
      } else {
        fill(c2, a2*(riverPointAlpha/255.));
      }
      vertex(x2, y2);
    }
    endShape();

    beginShape(TRIANGLE_STRIP);
    for (int i = 0; i < rPRs.size(); i++) {
      float x1 = ((riverPoint)rPRs.get(i)).px;
      float y1 = ((riverPoint)rPRs.get(i)).py;
      int c1 = ((riverPoint)rPRs.get(i)).fillColor;
      int a1 = ((riverPoint)rPRs.get(i)).fillAlpha;
      float x2 = ((riverPoint)rPCs.get(i)).px;
      float y2 = ((riverPoint)rPCs.get(i)).py;
      int c2 = ((riverPoint)rPCs.get(i)).fillColor;
      //ellipse(x, y, 5, 5);
      if ((i == 0)||(i == rPRs.size()-1)) {
        fill(c1, 0);
      } else {
        fill(c1, a1*(riverPointAlpha/255.));
      }
      vertex(x1, y1);

      fill(c2, 0);
      vertex(x1+(x1-x2)*0.5, y1+(y1-y2)*0.5);
    }
    endShape();
  }
  void generateInkRiver(float enterDec) {
    RISs.clear();
    fogs.clear();
    riverPointAlpha = 255;
    riverPointAlphaDec = enterDec;
    generateRiverInsideSpring(riverPointAlphaDec*1.5);
    generateFogs(enterDec);
  }
  boolean generateRightRiver() {
    for (int j = 0; j < 500; j++) {
      for (int i = 0; i < 100; i++) {
        rPLs.clear(); 
        rPRs.clear(); 
        rPCs.clear();
        generateRiver();
        if (abs(py1-py2) < height/2) {
          continue;
        } else {
          break;
        }
      }
      if (detect_touch_positions() == true) {
        continue;
      } else {
        break;
      }
    }
    if (detect_touch_positions() == true) {
      rPLs.clear(); 
      rPRs.clear(); 
      rPCs.clear();
      println("failure");
      return false;
    } else {
      println("OK!");
      return true;
    }
  }
}
