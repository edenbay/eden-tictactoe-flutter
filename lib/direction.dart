class Direction {
 static Direction left = Direction(0, -1);
 static Direction right = Direction(0, 1);
 static Direction up = Direction(-1, 0);
 static Direction down = Direction(1, 0);


//diagonal movement
static Direction leftUp = Direction(-1, -1);
static Direction rightUp = Direction(-1, 1);
static Direction leftDown = Direction(1, -1);
static Direction rightDown = Direction(1, 1);

        int rowOffset;
        int columnOffset;

      Direction(this.rowOffset, 
                this.columnOffset);

  static List<Direction> getStraights() {
    return  [
      left,
      right,
      up,
      down
    ];
  }
   
  static List<Direction> getDiagonals() {
    return  [
      leftUp,
      rightUp,
      leftDown,
      rightDown
    ];
  }     
}