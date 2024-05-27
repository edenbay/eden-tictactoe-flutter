
import 'package:tic_tac_toe/position.dart';



enum PieceType { empty, circle, cross }

class Piece {

  PieceType type = PieceType.empty;
  late int position;

  Piece(this.type, this.position);

   Piece updatePiece(PieceType pieceType) {
    type = pieceType;

    return this;
  }

  //static PieceType getType(Piece piece) => piece.type;

  

}

extension PieceGetter on Piece {
  PieceType getType() {
    return this.type;
  }
}

