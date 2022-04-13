class Ink_Mountain {
  float mPx, mPy, mW, mH, mShiftCPx, mShiftCPy;
  int mType;

  float randomMountainPointProbality;
  float mLeft_peak_proportion, mRight_peak_proportion;

  ArrayList mPoints1;
  ArrayList mPoints2, mPoints3, mPoints4, mPoints5, mPoints6;

  int centerColor, leftColor, rightColor, strokeColor;
  float proportionLength;

  float tempLeftPxShift, tempLeftPyShift, tempLeftPx, tempLeftPy;
  float tempRightPxShift, tempRightPyShift, tempRightPx, tempRightPy;

  float mPoints3_leftAddPx, mPoints3_leftAddPy, mPoints3_rightAddPx, mPoints3_rightAddPy;
  float mPoints4_leftAddPx, mPoints4_leftAddPy, mPoints4_rightAddPx, mPoints4_rightAddPy;
  float mPoints5_leftAddPx, mPoints5_leftAddPy, mPoints5_rightAddPx, mPoints5_rightAddPy;
  float mPoints6_leftAddPx, mPoints6_leftAddPy, mPoints6_rightAddPx, mPoints6_rightAddPy;
  float mPoints1_leftAddPx, mPoints1_leftAddPy, mPoints1_rightAddPx, mPoints1_rightAddPy;

  float mAlpha, mDecAlpha;

  Ink_Mountain(float enterMPx, float enterMPy, float enterMW, float enterMH, 
    float enterRandomMountainPointProbality, 
    float enterMLeftPeakProportion, float enterMRightPeakProportion, 
    float decA) {
    mPx = enterMPx;
    mPy = enterMPy;
    mW = enterMW;
    mH = enterMH;

    mPoints1 = new ArrayList();
    mPoints2 = new ArrayList();
    mPoints3 = new ArrayList();
    mPoints4 = new ArrayList();
    mPoints5 = new ArrayList();
    mPoints6 = new ArrayList();
    randomMountainPointProbality = enterRandomMountainPointProbality;
    mLeft_peak_proportion = enterMLeftPeakProportion;
    mRight_peak_proportion = enterMRightPeakProportion;

    mShiftCPx = random(-mW*0.3, mW*0.3);
    mShiftCPy = random(-mH*0.1, mW*0.1);

    centerColor = int(random(90, 150));
    leftColor = int(random(230, 255));
    rightColor = int(random(230, 255));
    proportionLength = random(0.8, 1.2);
    //strokeColor = int(random(50, 150));
    strokeColor = int(random(10, 100));
    mAlpha = 255;
    mDecAlpha = decA;
  }
  void generate_a_lof_of_point_mountain() {
    float keepValue = 0;
    for (float t = 0; t <= 1; ) {
      float randomTadd = 1-random(randomMountainPointProbality*0.8, randomMountainPointProbality);
      t = t + randomTadd;
      if (t > 1) {
        keepValue = t - 1;
        break;
      }
      float x = curvePoint(mPx-mW/2, mPx-mW/2, 
        mPx-(mW/2)*(-mLeft_peak_proportion), mPx+(mW/2)*(-mRight_peak_proportion), t);
      float y = curvePoint(mPy, mPy, mPy-mH, mPy-mH, t );
      float tx = curveTangent(mPx-mW/2, mPx-mW/2, 
        mPx-(mW/2)*(-mLeft_peak_proportion), mPx+(mW/2)*(-mRight_peak_proportion), t);
      float ty = curveTangent(mPy, mPy, mPy-mH, mPy-mH, t );
      float a = atan2(ty, tx);
      if (random(2) > 1) {
        a -= PI/2.0;
      } else {
        a += PI/2.0;
      }


      //mPoints2.add(new PVector(cos(a)*(mW+mH)*random(0.03) + x, sin(a)*(mW+mH)*random(0.03) + y, random(230, 255)));
      mPoints2.add(new mountainPoint(cos(a)*(mW+mH)*random(0.03) + x, sin(a)*(mW+mH)*random(0.03) + y, 
        int(random(200, 255)), 0, 0, int(random(230, 255))));

      a = atan2(ty, tx);
      a -= PI/2.0;
      mPoints1.add(new mountainPoint(
        ((mountainPoint)mPoints2.get(mPoints2.size()-1)).x - cos(a)*4, 
        ((mountainPoint)mPoints2.get(mPoints2.size()-1)).y - sin(a)*4, 
        int(random(0, 100)), 0, 0, 0));
      mPoints3.add(new mountainPoint(
        ((mountainPoint)mPoints2.get(mPoints2.size()-1)).x + cos(a)*4, 
        ((mountainPoint)mPoints2.get(mPoints2.size()-1)).y + sin(a)*4, 
        int(random(150, 200)), 0, 0, 0));
      mPoints4.add(new mountainPoint(
        ((mountainPoint)mPoints2.get(mPoints2.size()-1)).x + cos(a)*8, 
        ((mountainPoint)mPoints2.get(mPoints2.size()-1)).y + sin(a)*8, 
        int(random(100, 150)), 0, 0, 0));
      mPoints5.add(new mountainPoint(
        ((mountainPoint)mPoints2.get(mPoints2.size()-1)).x + cos(a)*12, 
        ((mountainPoint)mPoints2.get(mPoints2.size()-1)).y + sin(a)*12, 
        int(random(50, 100)), 0, 0, 0));
      mPoints6.add(new mountainPoint(
        ((mountainPoint)mPoints2.get(mPoints2.size()-1)).x + cos(a)*16, 
        ((mountainPoint)mPoints2.get(mPoints2.size()-1)).y + sin(a)*16, 
        int(random(0, 50)), 0, 0, 0));

      //ellipse(x, y, 7, 7);
    }
    boolean keepFlag = false;
    for (float t = 0; t <= 1; ) {
      float randomTadd = 1-random(randomMountainPointProbality*0.8, randomMountainPointProbality);
      if (keepFlag == false) {
        t = keepValue;
        keepFlag = true;
      } else {
        t = t + randomTadd;
      }
      if (t > 1) {
        keepValue = t - 1;
        break;
      }
      float x = curvePoint(mPx-mW/2, mPx-(mW/2)*(-mLeft_peak_proportion), 
        mPx+(mW/2)*(-mRight_peak_proportion), mPx+mW/2, t);
      float y = curvePoint(mPy, mPy-mH, mPy-mH, mPy, t );
      float tx = curveTangent(mPx-mW/2, mPx-(mW/2)*(-mLeft_peak_proportion), 
        mPx+(mW/2)*(-mRight_peak_proportion), mPx+mW/2, t);
      float ty = curveTangent(mPy, mPy-mH, mPy-mH, mPy, t );
      float a = atan2(ty, tx);
      if (random(2) > 1) {
        a -= PI/2.0;
      } else {
        a += PI/2.0;
      }
      mPoints2.add(new mountainPoint(cos(a)*(mW+mH)*random(0.01) + x, sin(a)*(mW+mH)*random(0.01) + y, 
        int(random(200, 255)), 0, 0, int(random(230, 255))));

      a = atan2(ty, tx);
      a -= PI/2.0;
      mPoints1.add(new mountainPoint(
        ((mountainPoint)mPoints2.get(mPoints2.size()-1)).x - cos(a)*4, 
        ((mountainPoint)mPoints2.get(mPoints2.size()-1)).y - sin(a)*4, 
        int(random(0, 100)), 0, 0, 0));
      mPoints3.add(new mountainPoint(
        ((mountainPoint)mPoints2.get(mPoints2.size()-1)).x + cos(a)*4, 
        ((mountainPoint)mPoints2.get(mPoints2.size()-1)).y + sin(a)*4, 
        int(random(150, 200)), 0, 0, 0));
      mPoints4.add(new mountainPoint(
        ((mountainPoint)mPoints2.get(mPoints2.size()-1)).x + cos(a)*8, 
        ((mountainPoint)mPoints2.get(mPoints2.size()-1)).y + sin(a)*8, 
        int(random(100, 150)), 0, 0, 0));
      mPoints5.add(new mountainPoint(
        ((mountainPoint)mPoints2.get(mPoints2.size()-1)).x + cos(a)*12, 
        ((mountainPoint)mPoints2.get(mPoints2.size()-1)).y + sin(a)*12, 
        int(random(50, 100)), 0, 0, 0));
      mPoints6.add(new mountainPoint(
        ((mountainPoint)mPoints2.get(mPoints2.size()-1)).x + cos(a)*16, 
        ((mountainPoint)mPoints2.get(mPoints2.size()-1)).y + sin(a)*16, 
        int(random(0, 50)), 0, 0, 0));
      //ellipse(x, y, 7, 7);
    }
    keepFlag = false;
    for (float t = 0; t <= 1; ) {
      float randomTadd = 1-random(randomMountainPointProbality*0.8, randomMountainPointProbality);
      if (keepFlag == false) {
        t = keepValue;
        keepFlag = true;
      } else {
        t = t + randomTadd;
      }
      if (t > 1) {
        keepValue = t - 1;
        break;
      }
      float x = curvePoint(mPx-(mW/2)*(-mLeft_peak_proportion), 
        mPx+(mW/2)*(-mRight_peak_proportion), mPx+mW/2, mPx+mW/2, t);
      float y = curvePoint(mPy-mH, mPy-mH, mPy, mPy, t );
      float tx = curveTangent(mPx-(mW/2)*(-mLeft_peak_proportion), 
        mPx+(mW/2)*(-mRight_peak_proportion), mPx+mW/2, mPx+mW/2, t);
      float ty = curveTangent(mPy-mH, mPy-mH, mPy, mPy, t );
      float a = atan2(ty, tx);
      if (random(2) > 1) {
        a -= PI/2.0;
      } else {
        a += PI/2.0;
      }

      mPoints2.add(new mountainPoint(cos(a)*(mW+mH)*random(0.01) + x, sin(a)*(mW+mH)*random(0.01) + y, 
        int(random(200, 255)), 0, 0, int(random(230, 255))));
      a = atan2(ty, tx);
      a -= PI/2.0;
      mPoints1.add(new mountainPoint(
        ((mountainPoint)mPoints2.get(mPoints2.size()-1)).x - cos(a)*4, 
        ((mountainPoint)mPoints2.get(mPoints2.size()-1)).y - sin(a)*4, 
        int(random(0, 100)), 0, 0, 0));
      mPoints3.add(new mountainPoint(
        ((mountainPoint)mPoints2.get(mPoints2.size()-1)).x + cos(a)*4, 
        ((mountainPoint)mPoints2.get(mPoints2.size()-1)).y + sin(a)*4, 
        int(random(150, 200)), 0, 0, 0));
      mPoints4.add(new mountainPoint(
        ((mountainPoint)mPoints2.get(mPoints2.size()-1)).x + cos(a)*8, 
        ((mountainPoint)mPoints2.get(mPoints2.size()-1)).y + sin(a)*8, 
        int(random(100, 150)), 0, 0, 0));
      mPoints5.add(new mountainPoint(
        ((mountainPoint)mPoints2.get(mPoints2.size()-1)).x + cos(a)*12, 
        ((mountainPoint)mPoints2.get(mPoints2.size()-1)).y + sin(a)*12, 
        int(random(50, 100)), 0, 0, 0));
      mPoints6.add(new mountainPoint(
        ((mountainPoint)mPoints2.get(mPoints2.size()-1)).x + cos(a)*16, 
        ((mountainPoint)mPoints2.get(mPoints2.size()-1)).y + sin(a)*16, 
        int(random(0, 50)), 0, 0, 0));
      //ellipse(x, y, 7, 7);
    }

    tempLeftPxShift = abs((mPx-mW/2)-((mountainPoint)mPoints2.get(0)).x);
    tempLeftPyShift = abs(mPy-((mountainPoint)mPoints2.get(0)).y);
    tempLeftPx = (mPx-mW/2)-tempLeftPxShift-random(tempLeftPxShift);
    tempLeftPy = mPy+tempLeftPyShift+random(tempLeftPyShift);
    tempRightPxShift = abs((mPx+mW/2)-((mountainPoint)mPoints2.get(mPoints2.size()-1)).x);
    tempRightPyShift = abs(mPy-((mountainPoint)mPoints2.get(mPoints2.size()-1)).y);
    tempRightPx = (mPx+mW/2)+tempRightPxShift+random(tempRightPxShift);
    tempRightPy = mPy+tempRightPyShift+random(tempRightPyShift);

    mPoints3_leftAddPx = random(1, 2);
    mPoints3_leftAddPy = random(1, 2);
    mPoints3_rightAddPx = random(1, 2);
    mPoints3_rightAddPy = random(1, 2);

    mPoints4_leftAddPx = random(3, 4);
    mPoints4_leftAddPy = random(3, 4);
    mPoints4_rightAddPx = random(3, 4);
    mPoints4_rightAddPy = random(3, 4);

    mPoints5_leftAddPx = random(5, 6);
    mPoints5_leftAddPy = random(5, 6);
    mPoints5_rightAddPx = random(5, 6);
    mPoints5_rightAddPy = random(5, 6);

    mPoints6_leftAddPx = random(7, 8);
    mPoints6_leftAddPy = random(7, 8);
    mPoints6_rightAddPx = random(7, 8);
    mPoints6_rightAddPy = random(7, 8);

    mPoints1_leftAddPx = random(1, 2);
    mPoints1_leftAddPy = random(1, 2);
    mPoints1_rightAddPx = random(1, 2);
    mPoints1_rightAddPy = random(1, 2);
  }

  PVector generateInnerPoints() {
    int randomPointNumber = int(random(mPoints2.size()));
    float tempPx = ((mountainPoint)mPoints2.get(randomPointNumber)).x;
    float tempPy = ((mountainPoint)mPoints2.get(randomPointNumber)).y;
    float randomProportion = random(0.9);
    float innerPx = tempPx*randomProportion+mPx*(1-randomProportion);
    float innerPy = tempPy*randomProportion+mPy*(1-randomProportion);
    PVector P = new PVector(innerPx, innerPy);
    return P;
  }

  void drawInkMountain(PGraphics P, boolean displayMode) {
    if (displayMode == true) {
      P.noStroke();
      P.beginShape(TRIANGLE_FAN);
      P.fill(centerColor, mAlpha);
      P.vertex(mPx+mShiftCPx, mPy);
      P.fill(leftColor, mAlpha);
      P.vertex(mPx-mW/2, mPy);
      for (int i = 0; i < mPoints2.size(); i++) {
        P.fill(((mountainPoint)mPoints2.get(i)).fillColor, mAlpha);
        P.vertex(((mountainPoint)mPoints2.get(i)).x, ((mountainPoint)mPoints2.get(i)).y);
      }
      P.fill(rightColor, mAlpha);
      P.vertex(mPx+mW/2, mPy);
      P.fill(centerColor, mAlpha);
      P.vertex(mPx+mShiftCPx, mPy);
      P.endShape();

      P.noStroke();
      P.beginShape();
      P.fill(leftColor, mAlpha);
      P.vertex(mPx-mW/2, mPy);
      P.fill(centerColor, mAlpha);
      P.vertex(mPx+mShiftCPx, mPy);
      P.fill(centerColor, 0);
      P.vertex(mPx+mShiftCPx, mPy+mH*proportionLength);
      P.fill(leftColor, 0);
      P.vertex(mPx-mW/2, mPy+mH*proportionLength);
      P.endShape();

      P.beginShape();
      P.fill(centerColor, mAlpha);
      P.vertex(mPx+mShiftCPx, mPy);
      P.fill(rightColor, mAlpha);
      P.vertex(mPx+mW/2, mPy);
      P.fill(rightColor, 0);
      P.vertex(mPx+mW/2, mPy+mH*proportionLength);
      P.fill(centerColor, 0);
      P.vertex(mPx+mShiftCPx, mPy+mH*proportionLength);
      P.endShape();
    }

    // stroke
    P.strokeCap(ROUND);
    P.strokeJoin(ROUND);
    P.strokeWeight(4);
    P.stroke(strokeColor, 0);
    P.noFill();
    P.beginShape();
    P.stroke(strokeColor, 0);
    P.vertex(tempLeftPx, tempLeftPy);
    P.stroke(strokeColor, 150*mAlpha/255);
    P.vertex(mPx-mW/2, mPy);
    for (int i = 0; i < mPoints2.size(); i++) {
      P.stroke(strokeColor, ((mountainPoint)mPoints2.get(i)).strokeAlpha*mAlpha/255);
      P.vertex(((mountainPoint)mPoints2.get(i)).x, ((mountainPoint)mPoints2.get(i)).y);
    }
    P.stroke(strokeColor, 150*mAlpha/255);
    P.vertex(mPx+mW/2, mPy);
    P.stroke(strokeColor, 0);
    P.vertex(tempRightPx, tempRightPy);
    P.endShape();

    if (displayMode == true) {
      P.beginShape();
      P.stroke(strokeColor, 100*mAlpha/255);
      P.vertex(tempLeftPx-mPoints3_leftAddPx, tempLeftPy+mPoints3_leftAddPy);
      for (int i = 0; i < mPoints3.size(); i++) {
        P.stroke(strokeColor, ((mountainPoint)mPoints3.get(i)).strokeAlpha*mAlpha/255);
        P.vertex(((mountainPoint)mPoints3.get(i)).x, ((mountainPoint)mPoints3.get(i)).y);
      }
      P.stroke(strokeColor, 100*mAlpha/255);
      P.vertex(tempRightPx+mPoints3_rightAddPx, tempRightPy+mPoints3_rightAddPy);
      P.endShape();

      P.beginShape();
      P.stroke(strokeColor, 50*mAlpha/255);
      P.vertex(tempLeftPx-mPoints4_leftAddPx, tempLeftPy+mPoints4_leftAddPy);
      for (int i = 0; i < mPoints4.size(); i++) {
        P.stroke(strokeColor, ((mountainPoint)mPoints4.get(i)).strokeAlpha*mAlpha/255);
        P.vertex(((mountainPoint)mPoints4.get(i)).x, ((mountainPoint)mPoints4.get(i)).y);
      }
      P.stroke(strokeColor, 50*mAlpha/255);
      P.vertex(tempRightPx+mPoints4_rightAddPx, tempRightPy+mPoints4_rightAddPy);
      P.endShape();


      P.beginShape();
      P.stroke(strokeColor, 25*mAlpha/255);
      P.vertex(tempLeftPx-mPoints5_leftAddPx, tempLeftPy+mPoints5_leftAddPy);
      for (int i = 0; i < mPoints5.size(); i++) {
        P.stroke(strokeColor, ((mountainPoint)mPoints5.get(i)).strokeAlpha*mAlpha/255);
        P.vertex(((mountainPoint)mPoints5.get(i)).x, ((mountainPoint)mPoints5.get(i)).y);
      }
      P.stroke(strokeColor, 25*mAlpha/255);
      P.vertex(tempRightPx+mPoints5_rightAddPx, tempRightPy+mPoints5_rightAddPy);
      P.endShape();

      P.beginShape();
      P.stroke(strokeColor, 12*mAlpha/255);
      P.vertex(tempLeftPx-mPoints6_leftAddPx, tempLeftPy+mPoints6_leftAddPy);
      for (int i = 0; i < mPoints6.size(); i++) {
        P.stroke(strokeColor, ((mountainPoint)mPoints6.get(i)).strokeAlpha);
        P.vertex(((mountainPoint)mPoints6.get(i)).x, ((mountainPoint)mPoints6.get(i)).y);
      }
      P.stroke(strokeColor, 12*mAlpha/255);
      P.vertex(tempRightPx+mPoints6_rightAddPx, tempRightPy+mPoints6_rightAddPy);
      P.endShape();

      P.beginShape();
      P.stroke(strokeColor, 50*mAlpha/255);
      P.vertex(tempLeftPx+mPoints1_leftAddPx, tempLeftPy+mPoints1_leftAddPy);
      for (int i = 0; i < mPoints1.size(); i++) {
        P.stroke(strokeColor, ((mountainPoint)mPoints1.get(i)).strokeAlpha*mAlpha/255);
        P.vertex(((mountainPoint)mPoints1.get(i)).x, ((mountainPoint)mPoints1.get(i)).y);
      }
      P.stroke(strokeColor, 50*mAlpha/255);
      P.vertex(tempRightPx-mPoints1_rightAddPx, tempRightPy+mPoints1_rightAddPy);
      P.endShape();
    }

    if (mAlpha > 0) {
      mAlpha = mAlpha - mDecAlpha;
      if (mAlpha < 0) {
        mAlpha = 0;
      }
    } else {
      mAlpha = 0;
    }
  }
  void drawMountainPoint(PGraphics P) {
    for (int i = 0; i < mPoints2.size(); i++) {
      float x = ((mountainPoint)mPoints2.get(i)).x;
      float y = ((mountainPoint)mPoints2.get(i)).y;
      P.noFill();
      P.strokeWeight(1);
      P.stroke(255, 0, 0);
      P.ellipse(x, y, 5, 5);
    }
  }

  PVector getRandomMountainPoint(int decRange) {
    int maxSize = mPoints2.size();
    int randomNumber = int(random(maxSize-decRange*2))+decRange;
    float x = ((mountainPoint)mPoints2.get(randomNumber)).x;
    float y = ((mountainPoint)mPoints2.get(randomNumber)).y;
    float a = atan2(y-mPy, x-mPx);
    PVector P = new PVector(x, y, a);
    return P;
  }

  boolean isInsideMountain(float enterPx, float enterPy) {
    float distance = dist(mPx, mPy, enterPx, enterPy);
    if (mW/2 > mH) {
      if (enterPy <= mPy) {
        if (distance < mH) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } else {
      if (enterPy <= mPy) {
        if (distance < mW/2) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    }
  }

  float getAlpha() {
    return mAlpha;
  }
}

class mountainPoint {
  float x, y;
  int strokeAlpha, strokeColor, fillAlpha, fillColor;
  mountainPoint(float enterX, float enterY, int enterSAlpha, int enterSColor, int enterFAlpha, int enterFColor) {
    x = enterX;
    y = enterY;
    strokeAlpha = enterSAlpha;
    strokeColor = enterSColor;
    fillAlpha = enterFAlpha;
    fillColor = enterFColor;
  }
} 
