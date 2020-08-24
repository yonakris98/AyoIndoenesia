import 'dart:io';
import 'dart:math';

class Player {
  int id;
  String playerName;
  String height;
  String weight;
  String position;
  String number;

  Player(this.id, this.playerName, this.height, this.weight, this.position,
      this.number);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'playerName': playerName,
      'height': height,
      'weight': weight,
      'position': position,
      'number': number,
    };
    return map;
  }

  Player.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    playerName = map['playerName'];
    height = map['height'];
    weight = map['weight'];
    position = map['position'];
    number = map['number'];
  }
}
