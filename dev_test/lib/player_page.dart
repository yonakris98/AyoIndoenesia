import 'package:dev_test/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:nice_button/nice_button.dart';
import 'global.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'db_helper.dart';
import 'player_class.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class PlayerPage extends StatefulWidget {
  @override
  State createState() => new PlayerPageState();
  static const routeName = '/player_page';
}

class PlayerPageState extends State<PlayerPage> {
  Future<List<Player>> player;
  final controllerPlayer = TextEditingController();
  final controllerHeight = TextEditingController();
  final controllerWeight = TextEditingController();
  final controllerPosition = TextEditingController();
  final controllerNumber = TextEditingController();

  final formKey = new GlobalKey<FormState>();
  var dbPlayer;

  String playerName, position, weight, height, number;

  List<String> listPosition = [
    'Penyerang',
    'Gelandang',
    'Bertahan',
    'Penjaga Gawang',
  ];

  @override
  void initState() {
    super.initState();
    dbPlayer = DBPlayer();
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
        title: new Text('Player Management'),
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
                        controller: controllerPlayer,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Player Name',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        validator: (val) =>
                            val.length == 0 ? 'Enter Name' : null,
                        onSaved: (val) => playerName = val,
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                      TextFormField(
                        controller: controllerHeight,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Height',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        validator: (val) =>
                            val.length == 0 ? 'Enter Name' : null,
                        onSaved: (val) => height = val,
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                      TextFormField(
                        controller: controllerWeight,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Weight',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        validator: (val) =>
                            val.length == 0 ? 'Enter Name' : null,
                        onSaved: (val) => weight = val,
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                      DropDownField(
                        value: position,
                        required: true,
                        strict: true,
                        labelText: 'Select Position',
                        // icon: Icon(Icons.account_balance),
                        items: listPosition,
                        setter: (dynamic newValue) {
                          position = newValue;
                        },
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                      TextFormField(
                        controller: controllerNumber,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Player Number',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        validator: (val) =>
                            val.length == 0 ? 'Enter Name' : null,
                        onSaved: (val) => number = val,
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
                            dbPlayer.savePlayer(
                              Player(null, playerName, height, weight, position,
                                  number),
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
