import 'dart:io';
import 'dart:math';

class Schedule {
  int id;
  String date;
  String time;
  String enemyTeam;
  String homeTeam;

  Schedule(this.id, this.date, this.time, this.enemyTeam, this.homeTeam);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'date': date,
      'time': time,
      'enemyTeam': enemyTeam,
      'homeTeam': homeTeam,
    };
    return map;
  }

  Schedule.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    date = map['date'];
    time = map['time'];
    enemyTeam = map['enemyTeam'];
    homeTeam = map['homeTeam'];
  }
}
