int state = 0; // 0=start, 1=play, 2=end
int startTime;
int duration = 20;
int score = 0;
boolean trails = false;

// player details
float px = 350, py = 175;
float step = 6;
float pr = 20;

// helper details
float hx, hy;      
float ease = 0.10;

// orb info
float x = 100, y = 100;
float xs = 4, ys = 3;
float r = 15;

void setup() {
  size(700, 350);
  hx = px; // helper position
  hy = py;
}

void draw() {
  if (!trails) {
    background(255);
  } else {
    noStroke();
    fill(255, 35);
    rect(0, 0, width, height);
  }
  //background(245);

  // START screen
  if (state == 0) {
    textAlign(CENTER, CENTER);
    textSize(24);
    fill(0);
    text("Press ENTER to Start", width/2, height/2);
  }

  // PLAY screen
  if (state == 1) {
    int elapsed = (millis() - startTime) / 1000; // convert ms to seconds
    int left = duration - elapsed;

    textAlign(LEFT, TOP);
    textSize(18);
    fill(0);
    text("Time Left: " + left, 20, 20);
    
    fill(0);
    textSize(16);
    text("Trails: " + (trails ? "ON" : "OFF") + " (Press T)", 20, 60);
    
    // player control
  if (keyPressed) {
    if (keyCode == RIGHT) px += step;
    if (keyCode == LEFT)  px -= step;
    if (keyCode == DOWN)  py += step;
    if (keyCode == UP)    py -= step;
  }
  
  // keep player inside the screen
  px = constrain(px, pr, width - pr);
  py = constrain(py, pr, height - pr);
  
  // easing follow
  hx = hx + (px - hx) * ease;
  hy = hy + (py - hy) * ease;
  
  // player
  fill(60, 120, 200);
  ellipse(px, py, pr*2, pr*2);

  // helper
  fill(80, 200, 120);
  ellipse(hx, hy, 16, 16);
  
  // orb
  x += xs;
  y += ys;
  
  if (x > width - r || x < r) xs *= -1;
  if (y > height - r || y < r) ys *= -1;

  fill(255, 120, 80);
  ellipse(x, y, r*2, r*2);
  
  if(dist(x, y, px, py) < r*2) {
    x = random(x);
    y = 200;
    
    score = score + 1;
  }
  
  textSize(18);
  fill(0);
  text("Score: " + score, 20, 40);

  if (left <= 0) {
    state = 2; // go to END screen
   }
  }
  
  // END screen
  if (state == 2) {
    textAlign(CENTER, CENTER);
    textSize(24);
    fill(0,255,0);
    text("Final Score: " +score,  width/2, (height/2+30) );
    fill(255,0,0);
    text("Time Over! Press R to Reset", width/2, height/2);
  }
}

void keyPressed() {
  // press ENTER to start playing
  if (state == 0 && keyCode == ENTER) {
    state = 1;
    startTime = millis();
  }
  
  if (key == 't' || key == 'T') {
    trails = !trails;
  }

  // press R to reset
  if (state == 2 && (key == 'r' || key == 'R')) {
    state = 0;
  }
}
