import 'package:dev_test/player_page.dart';
import 'package:dev_test/splash_screen.dart';
import 'package:dev_test/team_page.dart';
import 'package:dev_test/home.dart';
import 'package:flutter/material.dart';
import 'team_class.dart';
import 'dart:async';
import 'db_helper.dart';
import 'schedule_page.dart';
import 'team_page.dart';
import 'scale_route.dart';
import 'home.dart';
import 'report_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash_screen',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case (SplashScreen.routeName):
            return ScaleRoute(page: SplashScreen());
          case '/':
            return ScaleRoute(page: HomePage());
          case (TeamPage.routeName):
            return ScaleRoute(page: TeamPage());
          case (PlayerPage.routeName):
            return ScaleRoute(page: PlayerPage());
          case (SchedulePage.routeName):
            return ScaleRoute(page: SchedulePage());
          case (ReportPage.routeName):
            return ScaleRoute(page: ReportPage());
        }
      },
    );
  }
}
