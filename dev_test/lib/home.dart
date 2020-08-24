import 'package:dev_test/report_page.dart';
import 'package:dev_test/schedule_page.dart';
import 'package:flutter/material.dart';
import 'package:nice_button/NiceButton.dart';
import 'team_page.dart';
import 'player_page.dart';
import 'global.dart';

class HomePage extends StatefulWidget {
  @override
  State createState() => HomePageState();
  static const routeName = '/home_page';
}

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('XYZ Football Management'),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 25.0),
                ),
                NiceButton(
                  width: 255,
                  elevation: 5.0,
                  radius: 10,
                  text: "Team Management",
                  background: Colors.black54,
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      TeamPage.routeName,
                    );
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                ),
                NiceButton(
                  width: 255,
                  elevation: 5.0,
                  radius: 10,
                  text: "Player Management",
                  background: Colors.black54,
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      PlayerPage.routeName,
                    );
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                ),
                NiceButton(
                  width: 255,
                  elevation: 5.0,
                  radius: 10,
                  text: "Scheduling",
                  background: Colors.black54,
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      SchedulePage.routeName,
                    );
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                ),
                NiceButton(
                  width: 255,
                  elevation: 5.0,
                  radius: 10,
                  text: "Report Match",
                  background: Colors.black54,
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      ReportPage.routeName,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
