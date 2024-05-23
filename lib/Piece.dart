enum PieceType { empty, circle, cross }

class Piece {

  PieceType type = PieceType.empty;

  Piece(PieceType type) { this.type = type; }



   Piece updatePiece(PieceType pieceType) {
    type = pieceType;

    return this;
  }

}


