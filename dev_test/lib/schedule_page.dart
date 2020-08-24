import 'package:flutter/material.dart';
import 'global.dart';
import 'package:nice_button/nice_button.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'db_helper.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'schedule_class.dart';
import 'team_class.dart';

class SchedulePage extends StatefulWidget {
  @override
  State createState() => new SchedulePageState();
  static const routeName = '/schedule_page';
}

class SchedulePageState extends State<SchedulePage> {
  final formKey = new GlobalKey<FormState>();
  final controllerDate = TextEditingController();
  final controllerTime = TextEditingController();
  final controllerEnemyTeam = TextEditingController();
  final controllerHomeTeam = TextEditingController();
  final format = DateFormat("yyyy-MM-dd");
  final formatTime = DateFormat("HH:mm");
  List<Map<String, dynamic>> response = new List<Map<String, dynamic>>();

  String date, time;
  dynamic enemyTeam, homeTeam;
  var dbSchedule;

  List<DropdownMenuItem<dynamic>> list = [];

  Future<String> getTeam() async {
    final dbTeam = DBTeam();
    response = await dbTeam.getTeamName();
    print(response);
    for (int i = 0; i < response.length; i++) {
      list.add(
        DropdownMenuItem(
          child: Text(response[i]['name']),
          value: response[i]['id'],
        ),
      );
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getTeam();
    dbSchedule = DBSchedule();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: themeColor,
      appBar: new AppBar(
        title: new Text('Scheduling'),
        backgroundColor: Colors.black,
      ),
      body: new ListView(
        children: <Widget>[
          Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    verticalDirection: VerticalDirection.down,
                    children: <Widget>[
                      DateTimeField(
                        controller: controllerDate,
                        decoration: InputDecoration(
                          labelText: 'Match Date',
                        ),
                        format: format,
                        onShowPicker: (context, currentValue) {
                          return showDatePicker(
                              context: context,
                              firstDate: DateTime(1900),
                              initialDate: currentValue ?? DateTime.now(),
                              lastDate: DateTime(2100));
                        },
                        onSaved: (val) => date = val.toString(),
                      ),
                      DateTimeField(
                        format: formatTime,
                        decoration: InputDecoration(labelText: 'Match Time'),
                        onShowPicker: (context, currentValue) async {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(
                                currentValue ?? DateTime.now()),
                          );
                          return DateTimeField.convert(time);
                        },
                        onSaved: (val) => time = val.toString(),
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                      DropdownButtonFormField(
                        hint: Text('Enemy Team'),
                        value: enemyTeam,
                        items: list,
                        onChanged: (dynamic newValue) {
                          setState(() {
                            enemyTeam = newValue;
                          });
                        },
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                      DropdownButtonFormField(
                        hint: Text('Home Team'),
                        value: homeTeam,
                        items: list,
                        onChanged: (dynamic newValue) {
                          setState(() {
                            homeTeam = newValue;
                          });
                        },
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 60.0)),
                      NiceButton(
                        width: 255,
                        elevation: 5.0,
                        radius: 10,
                        text: "SUBMIT",
                        background: Colors.green,
                        onPressed: () {
                          if (formKey.currentState.validate()) {
                            formKey.currentState.save();
                            dbSchedule.saveSchedule(
                              Schedule(
                                null,
                                date,
                                time,
                                enemyTeam.toString(),
                                homeTeam.toString(),
                              ),
                            );
                            Alert(
                              context: context,
                              title: "SUCCESS",
                              desc: "Player Successfully Added",
                              buttons: [
                                DialogButton(
                                  child: Text(
                                    "DONE",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                  },
                                  color: Colors.green,
                                ),
                              ],
                            ).show();
                          } else {
                            Alert(
                              context: context,
                              title: "FAILED",
                              desc: "Player Fail to Add",
                              buttons: [
                                DialogButton(
                                  child: Text(
                                    "BACK",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                  color: Colors.red,
                                ),
                              ],
                            ).show();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
