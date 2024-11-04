//ball´s position and movement
int xpos, ypos;
int xdir, ydir;

//pad´s initial position and size
int padx, padwidth;

//brick
int brickRow = 2, brickColumn=10;
int brickWidth, brickHeight;
int [][] bricks = new int[brickRow][brickColumn];

//game status
int dead, play;

void setup(){
   //fullScreen();
   
   //canvas initialization
   size(800, 600);
   brickWidth = width/brickColumn;
   brickHeight = height/20;
   
   //parameter setting for a new game
   new_game();
}


void draw(){
  int i, j;
  
  // background clear
  background(0);
  
  //brick drawing
  for(i=0; i<brickRow; i++){
    for(j=0; j<brickColumn; j++){
      // if it is '1', a brick is snowing, otherwise it doesn´t appear.
      if (bricks[i][j] == 1) rect(j*brickWidth, i*brickHeight, brickWidth, brickHeight);
    }
  }
  
  if (dead == 1){
    text("DEAD!!, Click to play again", 10, height/2);
    
    if(mousePressed == true){
      new_game();
    }
  }
  
  if (play == 1){
    //ball drawing
    ellipse(xpos, ypos, 50, 50);
    
    // ball movement
    xpos += xdir;
    ypos += ydir;
    
    // drawing a pad at new position
    padx = mouseX;
    line(padx-padwidth, height-50, padx+padwidth, height-50);
    
    // bounce at left and right boundaries
    if ( xpos < 10 || xpos > width-10) xdir *= -1;
    
    // if the ball in the region of bricks
    if ( ypos < brickHeight*brickRow ) {
      // when the ball hits the bricks
      if ( bricks[ypos/brickHeight][xpos/brickWidth] == 1) {
        ydir *= -1;
        bricks[ypos/brickHeight][xpos/brickWidth] = 0;
      }
      else if ( ypos < 0) ydir *= -1;    // bounce at the top
    }
    
    // bounce at the pad
    if (ypos > height-50 && xpos>=padx-padwidth && xpos <=padx+padwidth ) {
      ydir *= -1;
    }
    
    // dead condition
    if (ypos > height-10) {
      dead = 1;
      play = 0;
    }
  }
}


void new_game(){
  int i, j;
  
  // ball and pad´s position initialization
  xpos = width / 2;
  ypos = height / 2;
  padx = width / 2;
  padwidth = 300;
  
  // game status
  dead = 0;
  play = 1;
  
  // brick initialization at the top
  for(i=0; i<brickRow; i++){
    for(j=0; j<brickColumn; j++){
      bricks[i][j] = 1;
    }
  }
  
  // ball moves random direction
  xdir = 4;
  ydir = 6;
  
  
  // appearence for ball, bricks, pad
  fill(100);
  strokeWeight(2);
  stroke(255);
}
