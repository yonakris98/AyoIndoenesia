import 'package:flutter/material.dart';
import 'global.dart';
import 'package:nice_button/nice_button.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'db_helper.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'report_class.dart';

class ReportPage extends StatefulWidget {
  @override
  State createState() => new ReportPageState();
  static const routeName = '/report_page';
}

class ReportPageState extends State<ReportPage> {
  final formKey = new GlobalKey<FormState>();
  final controllerTotalScore = TextEditingController();
  final controllerGoalPlayer = TextEditingController();
  final format = DateFormat("yyyy-MM-dd");
  final formatTime = DateFormat("HH:mm");

  String totalScore, goalTime;
  dynamic goalPlayer;
  List<Map<String, dynamic>> response = new List<Map<String, dynamic>>();
  List<DropdownMenuItem<dynamic>> list = [];
  var dbReport;

  Future<String> getPlayer() async {
    final dbPlayer = DBPlayer();
    response = await dbPlayer.getPlayerName();
    print(response);
    for (int i = 0; i < response.length; i++) {
      list.add(
        DropdownMenuItem(
          child: Text(response[i]['playerName']),
          value: response[i]['id'],
        ),
      );
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    dbReport = DBReport();
    getPlayer();
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
        title: new Text('Report Match'),
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
                      Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                      TextFormField(
                        controller: controllerTotalScore,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Total Score',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        validator: (val) =>
                            val.length == 0 ? 'Enter Total Score' : null,
                        onSaved: (val) => totalScore = val,
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                      DropdownButtonFormField(
                        hint: Text('Player Scorer'),
                        value: goalPlayer,
                        items: list,
                        onChanged: (dynamic newValue) {
                          setState(() {
                            goalPlayer = newValue;
                          });
                        },
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                      DateTimeField(
                        format: formatTime,
                        decoration: InputDecoration(labelText: 'Goal Time'),
                        onShowPicker: (context, currentValue) async {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(
                                currentValue ?? DateTime.now()),
                          );
                          return DateTimeField.convert(time);
                        },
                        onSaved: (val) => goalTime = val.toString(),
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
                            dbReport.saveReport(
                              Report(
                                null,
                                totalScore,
                                goalPlayer.toString(),
                                goalTime,
                              ),
                            );
                            Alert(
                              context: context,
                              title: "SUCCESS",
                              desc: "Report Successfully Added",
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
                              desc: "Report Fail to Add",
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
