import 'enums/piece_type.dart';

class Piece {
  PieceType type = PieceType.none;
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
    return type;
  }
}
