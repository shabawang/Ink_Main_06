// generate random mountains
int maxNumber;
float minDistance;
ArrayList mPs, ims;

// river
PImage [] imageFogs;
InkRiver ir1;

// Trees
ArrayList backRoots, backLeafs;
ArrayList frontRoots, frontLeafs;
PImage [] leafs;
PGraphics backTreeP, frontTreeP;

// Mountain
PGraphics mountainP, P2;

void setup() {
  size(1080, 1080, P3D);
  mountainP = createGraphics(1080, 1080, P2D);
  P2 = createGraphics(1080, 1080, P2D);
  // generate random mountains
  mPs = new ArrayList();
  maxNumber = 15;
  minDistance = 80;
  calCircleDist(width/2, height/2, 200, 5);

  // Ink_mountains
  ims = new ArrayList();

  // Ink_tree
  backTreeP = createGraphics(1080, 1080, P3D);
  frontTreeP = createGraphics(1080, 1080, P3D);

  backRoots = new ArrayList();
  backLeafs = new ArrayList();
  frontRoots = new ArrayList();
  frontLeafs = new ArrayList();

  leafs = new PImage[5];
  imageFogs = new PImage[11];

  loadFile();

  // Ink_river
  ir1 = new InkRiver(3);

  mountainP.smooth(4);
  backTreeP.smooth(4);
  frontTreeP.smooth(4);
}
void draw() {
  surface.setTitle(nf(frameRate));
  for (int i = 0; i < backRoots.size(); i++) {
    if (((backRoot)backRoots.get(i)).timeAlpha < 0.5) {
      backRoots.remove(i);
    }
  }
  for (int i = 0; i < backLeafs.size(); i++) {
    if (((backLeaf)backLeafs.get(i)).alpha < 0.5) {
      backLeafs.remove(i);
    }
  }
  for (int i = 0; i < frontRoots.size(); i++) {
    if (((frontRoot)frontRoots.get(i)).timeAlpha < 0.5) {
      frontRoots.remove(i);
    }
  }
  for (int i = 0; i < frontLeafs.size(); i++) {
    if (((frontLeaf)frontLeafs.get(i)).alpha < 0.5) {
      frontLeafs.remove(i);
    }
  }
  for (int i = 0; i < ims.size(); i++) {
    if ( ((Ink_Mountain)ims.get(i)).mAlpha < 0.5 ) {
      ims.remove(i);
    }
  }

  background(255);
  backTreeP.beginDraw();
  backTreeP.hint(DISABLE_DEPTH_TEST);
  backTreeP.background(255, 0);
  drawBackTree(leafs, backTreeP, true);
  backTreeP.endDraw();

  mountainP.beginDraw();
  mountainP.background(255, 0);
  for (int i = 0; i < ims.size(); i++) {
    ((Ink_Mountain)ims.get(i)).drawInkMountain(mountainP, true);
  }
  mountainP.endDraw();

  frontTreeP.beginDraw();
  frontTreeP.hint(DISABLE_DEPTH_TEST);
  frontTreeP.background(255, 0);
  drawFrontTree(leafs, frontTreeP, true);
  frontTreeP.endDraw();

  P2.beginDraw();
  P2.background(255, 0);
  P2.fill(255, 0, 0);
  P2.stroke(0);
  P2.endDraw();

  imageMode(CORNER);
  tint(255, 255);
  image(backTreeP, 0, 0);
  image(mountainP, 0, 0);
  image(frontTreeP, 0, 0);

  //ir1.drawAvoidPos();
  ir1.drawInkRiver();
  //image(P2, 0, 0);

  boolean isInsideFlag = false;
  for (int i = 0; i < ims.size(); i++) {
    if (((Ink_Mountain)ims.get(i)).isInsideMountain(mouseX, mouseY) == true) {
      isInsideFlag = true;
      break;
    }
  }
  if (isInsideFlag == true) {
    fill(255, 0, 0);
  } else {
    fill(0, 255, 0);
  }
  ellipse(mouseX, mouseY, 9, 9);
}

void keyPressed() {
  if (key == '1') {
    //backRoots.clear();
    //backLeafs.clear();
    //frontRoots.clear();
    //frontLeafs.clear();
    for (int j = 0; j < 5; j++) {
      if (ims.size() < 1) {
        break;
      }
      int randomMountainNumber = int(random(ims.size()));
      if (((Ink_Mountain)ims.get(randomMountainNumber)).mAlpha < 128) {
        continue;
      }
      PVector P = ((Ink_Mountain)ims.get(randomMountainNumber)).getRandomMountainPoint(2);
      boolean isInsideMountain = false;
      for (int k = 0; k < ims.size(); k++) {
        if (((Ink_Mountain)ims.get(k)).isInsideMountain(P.x, P.y) == true) {
          isInsideMountain = true;
          break;
        }
      }
      if (isInsideMountain == true) {
        generateFrontTree(random(3, 5), P.x, P.y+5, degrees(P.z), random(5, 6));
      } else {
        generateBackTree(random(3, 5), P.x, P.y+10, degrees(P.z), random(5, 6));
      }
    }
  }
  if (key == '2') {
    //generate_a_lot_of_mountains(random(2, 2.5));
    generate_a_lot_of_mountains(5);
    for (int i = 0; i < ims.size(); i++) {
      float avoidX = ((Ink_Mountain)ims.get(i)).mPx;
      float avoidY = ((Ink_Mountain)ims.get(i)).mPy;
      float mW = ((Ink_Mountain)ims.get(i)).mW/2;
      float mAlpha = ((Ink_Mountain)ims.get(i)).mAlpha;
      float mAlphaDec = ((Ink_Mountain)ims.get(i)).mDecAlpha;
      ir1.addAvoidPos(avoidX, avoidY, mW, mAlpha, mAlphaDec);
    }
    //generate_a_lot_of_mountains(5);
  }
  if (key == '3') {
    ir1.generateInkRiver(3);
  }
  if (key == 'c') {
    backRoots.clear();
    backLeafs.clear();
    frontRoots.clear();
    frontLeafs.clear();
    mPs.clear();
    ims.clear();
  }
}
