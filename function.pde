// The second version
void calCircleDist(float x, float y, float R, int i) {
  //ellipse(x, y, R, R);
  int max = int(random(3)+1);
  for (int j = 0; j < max; j++) {
    float a = random(360);
    float proportion = random(0.4, 0.8);
    float newPx = x+R*cos(radians(a));
    float newPy = y+R*sin(radians(a));
    boolean valFlag = false;
    for (int k = 0; k < 5; k++) {
      a = random(360);
      proportion = random(0.4, 0.8);
      newPx = x+R*cos(radians(a));
      newPy = y+R*sin(radians(a));
      valFlag = false;
      for (int l = 0; l < mPs.size(); l++) {
        float px = ((PVector)mPs.get(l)).x;
        float py = ((PVector)mPs.get(l)).y;
        if (dist(newPx, newPy, px, py) < minDistance) {
          valFlag = true;
          break;
        }
      }
      if (valFlag == true) {
        continue;
      } else {
        break;
      }
    }
    if (i > 0) {
      if ((valFlag == false)&&(mPs.size() < maxNumber)) {
        mPs.add(new PVector(newPx, newPy));
        calCircleDist(newPx, newPy, R*proportion, i-1);
      }
    }
  }
}

void growMountain(float cpx, float cpy, float mW, float mH, int mountainNumber, float decA) {
  ims.add(new Ink_Mountain(cpx, cpy, mW, mH, 0.9, -random(0.4, 0.6), -random(0.4, 0.6), decA));
  int nowMountainNumber = ims.size()-1;
  ((Ink_Mountain)ims.get(nowMountainNumber)).generate_a_lof_of_point_mountain();
  for (int i = 0; i < mountainNumber; i++) {
    PVector a = ((Ink_Mountain)ims.get(nowMountainNumber)).generateInnerPoints().copy();
    mW = mW*random(0.6, 0.9);
    mH = mH*random(0.7, 0.9);
    ims.add(new Ink_Mountain(a.x, a.y, mW, mH, 0.9, -0.5, -0.5, decA));
    ((Ink_Mountain)ims.get(ims.size()-1)).generate_a_lof_of_point_mountain();
  }
}

void generate_a_lot_of_mountains(float decA) {
  //ims.clear();
  mPs.clear();
  calCircleDist(width/2, height/2, 200, 5);
  for (int i = 0; i < mPs.size(); i++) {
    float px = ((PVector)mPs.get(i)).x;
    float py = ((PVector)mPs.get(i)).y;
    growMountain(px, py, random(100, 200), random(100, 200), 5, decA);
  }
}
