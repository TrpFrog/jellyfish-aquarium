Aquarium aquarium = new Aquarium();
long startTime = millis();

void setup() {
    size(1060, 600, P3D);
    setupTextures();
    
    noStroke();
}

void draw() {
    pushMatrix();
        translate(width / 2, height / 2);
        cameraWork.update();

        lights();
        spotLight(150, 130, 160, 0, 1000, 0, 0, -1, 0, PI, 2);

        translate(0, -70, 0);
        background(#202030);
        scale(2);
        drawFloor(100);
        aquarium.draw();
        drawStand(100);
    popMatrix();
    drawHowToUse();
}

void drawHowToUse() {
    hint(DISABLE_DEPTH_TEST);
    textSize(20);
    long alpha = 15000 - (millis() - startTime);
    if(alpha < 0) return;
    fill(255, 255, 255, (int)constrain(alpha, 0, 255));
    final int padding = 30;
    text("Camera direction: Drug", padding, height - padding * 6);
    text("Camera position: WASD", padding, height - padding * 5);
    text("Zoom in/out: Mouse wheel", padding, height - padding * 4);
    text("Reset camera: Center click", padding, height - padding * 3);
    text("Feed: Right click", padding, height - padding * 2);
    text("Change speed: J/K", padding, height - padding);
}

void drawStand(int standHeight) {
    pushMatrix();
        translate(0, -standHeight / 2 - aquarium.getFrameThickness(), 0);
        texturedBox(
            aquarium.getWidth() + aquarium.getFrameThickness() + 2,
            standHeight,
            aquarium.getDepth() + aquarium.getFrameThickness() + 2,
            MARBLE_TEXTURE
        );
    popMatrix();
}

void drawFloor(int standHeight) {
    final int floorSize = 10000;
    repeatTile(
        new PVector(-floorSize/2, -standHeight, -floorSize/2),
        floorSize, floorSize,
        FLOOR_TEXTURE, 500
    );
}
