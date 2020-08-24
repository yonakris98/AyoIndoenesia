import 'dart:io';
import 'dart:math';

class Report {
  int id;
  String totalScore;
  String goalPlayer;
  String goalTime;

  Report(this.id, this.totalScore, this.goalPlayer, this.goalTime);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'totalScore': totalScore,
      'goalPlayer': goalPlayer,
      'goalTime': goalTime,
    };
    return map;
  }

  Report.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    totalScore = map['totalScore'];
    goalPlayer = map['goalPlayer'];
    goalTime = map['goalTime'];
  }
}
