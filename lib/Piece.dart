
import 'package:tictactoe/position.dart';

enum PieceType { empty, circle, cross }

class Piece {

  PieceType type = PieceType.empty;
  late Position position;

  Piece(PieceType type, Position position) 
  { 
    this.type = type;
    this.position = position;
  }

   Piece updatePiece(PieceType pieceType) {
    type = pieceType;

    return this;
  }

}


