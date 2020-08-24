import 'dart:io';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'team_class.dart';
import 'dart:async';
import 'db_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'global.dart';
import 'package:nice_button/nice_button.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class TeamPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TeamPageState();
  }

  static const routeName = '/team_page';
}

class TeamPageState extends State<TeamPage> {
  Future<List<Team>> team;
  final controllerName = TextEditingController();
  final controllerAddress = TextEditingController();
  final controllerCity = TextEditingController();
  final controllerSince = TextEditingController();
  final formKey = new GlobalKey<FormState>();
  String name, address, city, since;
  File _image;

  var dbTeam;
  final picker = ImagePicker();
  final format = DateFormat("yyyy-MM-dd");

  @override
  void initState() {
    super.initState();
    dbTeam = DBTeam();
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Team Management'),
        backgroundColor: Colors.black,
      ),
      body: new ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          new Column(
            children: <Widget>[
              Form(
                key: formKey,
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    verticalDirection: VerticalDirection.down,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                      TextFormField(
                        controller: controllerName,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        validator: (val) =>
                            val.length == 0 ? 'Enter Name' : null,
                        onSaved: (val) => name = val,
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                      TextFormField(
                        controller: controllerAddress,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Address',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        validator: (val) =>
                            val.length == 0 ? 'Enter Address' : null,
                        onSaved: (val) => address = val,
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                      TextFormField(
                        controller: controllerCity,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'City',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        validator: (val) =>
                            val.length == 0 ? 'Enter City' : null,
                        onSaved: (val) => city = val,
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                      DateTimeField(
                        controller: controllerSince,
                        decoration: InputDecoration(
                          labelText: 'Since',
                        ),
                        format: format,
                        onShowPicker: (context, currentValue) {
                          return showDatePicker(
                              context: context,
                              firstDate: DateTime(1900),
                              initialDate: currentValue ?? DateTime.now(),
                              lastDate: DateTime(2100));
                        },
                        onSaved: (val) => since = val.toString(),
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 15.0)),
                      _image == null
                          ? Text('Upload Team Logo')
                          : Image.file(_image),
                      _image == null
                          ? FloatingActionButton(
                              backgroundColor: Colors.blue,
                              onPressed: getImage,
                              tooltip: 'Pick Image',
                              child: Icon(
                                Icons.folder_open,
                              ),
                            )
                          : new Container(),
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
                            dbTeam.save(
                              Team(null, name, address, city, since,
                                  _image.toString()),
                            );
                            Alert(
                              context: context,
                              title: "SUCCESS",
                              desc: "Team Successfully Added",
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
                              desc: "Team Fail to Add",
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
