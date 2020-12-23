import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './api.dart';
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _nama = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _no_tlp_hp = TextEditingController();
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _level = TextEditingController();

  String baseUrl = Api.regis;

  String msg = "";

  static const items = <String>["admin", "user"];

  List<DropdownMenuItem<String>> _myitems = items
      .map((e) => DropdownMenuItem(
    value: e,
    child: Text(e),
  ))
      .toList();

  String valueItem = "admin";

  insertApi() async {
    final res = await http.post(baseUrl, body: {
      'nama': _nama.text,
      'email': _email.text,
      'no_tlp_hp': _no_tlp_hp.text,
      'username': _username.text,
      'password': _password.text,
      'level': valueItem
    });

    final dataJson = jsonDecode(res.body);

    _nama.clear();
    _email.clear();
    _no_tlp_hp.clear();
    _username.clear();
    _password.clear();
    _level.clear();

    if (dataJson['status'] == 1) {
      print(dataJson['msg']);
      showDialog(
          context: context,
          builder: (c) {
            return AlertDialog(
              title: Text("Notifikasi"),
              content: Text(dataJson['msg']),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Close"),
                )
              ],
            );
          });
      setState(() {
        msg = dataJson['msg'];
      });
    } else if (dataJson['status'] == 2) {
      print(dataJson['msg']);
      Navigator.of(context).pop();
      setState(() {
        msg = "";
      });
    } else {
      print(dataJson['msg']);
      setState(() {
        msg = dataJson['msg'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: ListView(
            children: <Widget>[

              // Field Nama

              Container(
                alignment: Alignment.center,
                padding:
                EdgeInsets.only(left: 25.0, right: 25.0, bottom: 25.0),
                child: TextField(
                  controller: _nama,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Name",
                      hintText: "Name"),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),

              // Field No Telp

              Container(
                alignment: Alignment.center,padding:
              EdgeInsets.only(left: 25.0, right: 25.0, bottom: 25.0),
                child: TextField(
                  controller: _no_tlp_hp,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    labelText: "No Telp",
                    hintText: "No Telp"),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),

              // Field Email

              Container(
                alignment: Alignment.center,padding:
              EdgeInsets.only(left: 25.0, right: 25.0, bottom: 25.0),
                child: TextField(
                  controller: _email,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "E-Mail",
                      hintText: "E-Mail"
                ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),

              // Field Username

              Container(
                alignment: Alignment.center,padding:
              EdgeInsets.only(left: 25.0, right: 25.0, bottom: 25.0),
                child: TextField(
                  controller: _username,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Username",
                      hintText: "Username"),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),

              //Field Password

              Container(
                alignment: Alignment.center,padding:
              EdgeInsets.only(left: 25.0, right: 25.0, bottom: 25.0),
                child: TextField(
                  controller: _password,
                  obscureText: true,decoration: InputDecoration(
                    border: OutlineInputBorder(),
                      labelText: "Password",
                      hintText: "Password"),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),

              // FIeld Level

              Container(
                  alignment: Alignment.center,padding:
              EdgeInsets.only(left: 25.0, right: 25.0, bottom: 25.0),
                  child:
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey)
                    ),
                    child: ListTile(
                        title: Text("Status / Level : "),
                        trailing: DropdownButton(
                          items: _myitems,
                          value: valueItem,
                          onChanged: (e) {
                            setState(() {
                              valueItem = e;
                            });
                          },
                        )),
                  )),
              SizedBox(
                height: 20.0,
              ),


              Material(
                borderRadius: BorderRadius.circular(20.0),
                elevation: 10.0,
                color: Colors.blueAccent,
                child: MaterialButton(
                  onPressed: () {
                    insertApi();
                  },
                  color: Colors.blueAccent,
                  child: Text("REGISTER"),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Center(
                child: Text(msg, style: TextStyle(color: Colors.blueAccent)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
