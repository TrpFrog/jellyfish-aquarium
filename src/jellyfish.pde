class Jellyfish extends MovableAquaticLife {

    private final float jellyfishHeadHeight = 10;
    private final float jellyfishHeadRadiusMax = 10;
    private final float jellyfishPeriod = 10000;
    private Seaweed foot = new Seaweed(4, 14, 1, 3, jellyfishPeriod);

    public Jellyfish() {
    }

    @Override
    public void draw() {
        drawHead();
        drawFeet();
    }

    private void drawHead() {
        float ms = millis();
        fill(#a9ceec, 120);
        beginShape(QUADS);
        int dtheta = 24;
        for(int y1 = 0; y1 < jellyfishHeadHeight - 0.5; y1 += 1) {
            float y2 = y1 + 1;
            boolean isHead = y1 == (int)(jellyfishHeadHeight - 1 + 0.001);
            for(int i = 0; i < 360; i += dtheta) {
                pushMatrix();
                float theta1 = radians(i);
                float theta2 = radians(i + dtheta);
                float r1 = getRadius(y1, ms);
                float r2 = getRadius(y2, ms);
                vertex(r1 * cos(theta1), y1, r1 * sin(theta1));
                if(isHead) {
                    r2 = r2 * 0.5;
                    vertex(r2 * cos(theta1), (y1 + y2) / 2, r2 * sin(theta1));
                    vertex(r2 * cos(theta2), (y1 + y2) / 2, r2 * sin(theta2));
                } else {
                    vertex(r2 * cos(theta1), y2, r2 * sin(theta1));
                    vertex(r2 * cos(theta2), y2, r2 * sin(theta2));
                }
                vertex(r1 * cos(theta2), y1, r1 * sin(theta2));
                popMatrix();
            }
        }
        endShape();
    }

    private void drawFeet() {
        fill(#a9ceec, 120);
        final float ms = millis();
        pushMatrix();
        translate(0, jellyfishHeadHeight * 0.4, 0);
        rotateX(PI);
        for(int i = 0; i < 10; i++) {
            rotateY(radians(360 / 10));
            pushMatrix();
                translate(0, 0, jellyfishHeadRadiusMax * 0.3);
                rotateX(radians(30 * pow(sin(ms / jellyfishPeriod * TWO_PI), 2)));
                foot.draw();
            popMatrix();
        }
        popMatrix();
    }

    private float getRadius(float y, float t) {
        final float h = jellyfishHeadHeight;
        final float r = jellyfishHeadRadiusMax;
        final float a = -50 / 25.0 * r / (h * h)
                * (0.7 + 0.5 * pow(sin(t / jellyfishPeriod * TWO_PI), 2));
        return a * (y + 0.25 * h) * (y - h);
    }
}