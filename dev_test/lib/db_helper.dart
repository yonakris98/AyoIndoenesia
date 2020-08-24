import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'team_class.dart';
import 'player_class.dart';
import 'schedule_class.dart';
import 'report_class.dart';

class DBTeam {
  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'team.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE team (id INTEGER PRIMARY KEY, name TEXT, address TEXT, city TEXT, since TEXT, logo TEXT)");
  }

  Future<Team> save(Team team) async {
    print("masuk insert team");
    print(team.name);
    print(team.address);
    print(team.city);
    print(team.since);
    print(team.logo);

    var dbClient = await db;
    team.id = await dbClient.insert('Team', team.toMap());
    return team;
  }

  Future<List<Map<String, dynamic>>> getTeamName() async {
    var dbClient = await db;
    return await dbClient.rawQuery('select id,name from team');
  }
}

class DBPlayer {
  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'player.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE player (id INTEGER PRIMARY KEY, playerName TEXT, height INTEGER, weight INTEGER, position TEXT, number INTEGER)");
  }

  Future<Player> savePlayer(Player player) async {
    print("masuk insert player");
    print(player.height);
    var dbClient = await db;
    player.id = await dbClient.insert('player', player.toMap());
    return player;
  }

  Future<List<Map<String, dynamic>>> getPlayerName() async {
    var dbClient = await db;
    return await dbClient.rawQuery('select id,playerName from player');
  }
}

class DBSchedule {
  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'schedule.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE schedule (id INTEGER PRIMARY KEY, date TEXT, time TEXT, enemyTeam TEXT, homeTeam TEXT)");
  }

  Future<Schedule> saveSchedule(Schedule schedule) async {
    print("masuk insert schedule");
    print(schedule.date);
    print(schedule.time);
    print(schedule.enemyTeam);
    print(schedule.homeTeam);
    var dbClient = await db;
    schedule.id = await dbClient.insert('schedule', schedule.toMap());
    return schedule;
  }
}

class DBReport {
  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'report.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE report (id INTEGER PRIMARY KEY, totalScore INTEGER, goalPlayer TEXT, goalTime TEXT)");
  }

  Future<Report> saveReport(Report report) async {
    print("masuk insert report");
    print(report.totalScore);
    print(report.goalPlayer);
    print(report.goalTime);
    var dbClient = await db;
    report.id = await dbClient.insert('report', report.toMap());
    return report;
  }
}
