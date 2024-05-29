



import 'position.dart';

enum PieceType { empty, circle, cross }

class Piece {

  PieceType type = PieceType.empty;
  late int position;
  final List<int> gridPosition = [];

  Piece(this.type, this.position);

   Piece updatePiece(PieceType pieceType) {
    type = pieceType;

    return this;
  }

  //static PieceType getType(Piece piece) => piece.type;

  void setGridPosition(Position pos) {

    if (gridPosition.isEmpty) {
      gridPosition.add(pos.row);
      gridPosition.add(pos.column);
    }
    
  }
  
}

extension PieceGetter on Piece {
  PieceType getType() {
    return type;
  }
}

