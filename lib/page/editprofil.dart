import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_signup_screen/restapi/restapi.dart';
import 'package:lottie/lottie.dart';

import 'bottom_navbar.dart';
import 'navpage4.dart';

class Editprofil extends StatefulWidget {
  final String name;
  final String lastname;
  final String gender;
  final String email;
  final String hp;
  final String id;

  const Editprofil({
    Key key,
    this.name,
    this.id,
    this.lastname,
    this.gender,
    this.email,
    this.hp,
  }) : super(key: key);

  @override
  _EditprofilState createState() => _EditprofilState();
}

class _EditprofilState extends State<Editprofil> {
  TextEditingController name = new TextEditingController();
  TextEditingController lastname = new TextEditingController();
  TextEditingController gender = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController hp = new TextEditingController();
  bool _checkbox = false;
  bool _checkbox1 = false;
  String jk = "";

  simpan() async {
    print(widget.id);
    print(name.text);
    print(lastname.text);
    print(email.text);
    print(hp.text);
    print(jk);
    final response = await http.post(Uri.parse(Restapi.editprofil), body: {
      "id": widget.id,
      "name": name.text,
      "lastname": lastname.text,
      "email": email.text,
      "gender": jk,
      "hp": hp.text,
    });

    final data = jsonDecode(response.body);
    String value = data['value'];
    String pesan = data['message'];

    if (value == "1") {
      _pesan();
    } else {
      print(print);
    }
  }

  Future<void> _pesan() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Lottie.asset('assets/4210-information.json',
              height: 100, width: 40),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                  'Profil anda berhasil di update',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BottomNavigation2Page()));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name.text = widget.name;
    lastname.text = widget.lastname;
    email.text = widget.email;
    hp.text = widget.hp;

    if (widget.gender == "Pria") {
      _checkbox = true;
      jk = "Pria";
      print(jk);
    } else {
      _checkbox1 = true;
      jk = "Wanita";
      print(jk);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.redAccent,
          title: Text(
            "Edit Profil",
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'Kalilight',
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "First Name",
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Kalilight',
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Color(0xffffffff),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 1,
                        color: Color(0xff737373),
                      ),
                    ],
                    gradient: null,
                    borderRadius: BorderRadius.all(Radius.circular(
                      7,
                    ))),
                child: TextFormField(
                  controller: name,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[400]),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[400]))),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Last Name",
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Kalilight',
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Color(0xffffffff),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 1,
                        color: Color(0xff737373),
                      ),
                    ],
                    gradient: null,
                    borderRadius: BorderRadius.all(Radius.circular(
                      7,
                    ))),
                child: TextFormField(
                  controller: lastname,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[400]),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[400]))),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Email",
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Kalilight',
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Color(0xffffffff),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 1,
                        color: Color(0xff737373),
                      ),
                    ],
                    gradient: null,
                    borderRadius: BorderRadius.all(Radius.circular(
                      7,
                    ))),
                child: TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[400]),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[400]))),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Gender",
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Kalilight',
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: _checkbox,
                        onChanged: (value) {
                          setState(() {
                            _checkbox = true;
                            _checkbox1 = false;
                            jk = "Pria";
                          });
                        },
                      ),
                      Text(
                        'Male',
                        style: TextStyle(
                          fontFamily: 'Kalilight',
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: _checkbox1,
                        onChanged: (value) {
                          setState(() {
                            _checkbox1 = true;
                            _checkbox = false;
                            jk = "Wanita";
                          });
                        },
                      ),
                      Text(
                        'Female',
                        style: TextStyle(
                          fontFamily: 'Kalilight',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "HP/WhatsApp",
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Kalilight',
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Color(0xffffffff),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 1,
                        color: Color(0xff737373),
                      ),
                    ],
                    gradient: null,
                    borderRadius: BorderRadius.all(Radius.circular(
                      7,
                    ))),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: hp,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.phone,
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[400]),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[400]))),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border(
                        bottom: BorderSide(color: Colors.black),
                        top: BorderSide(color: Colors.black),
                        left: BorderSide(color: Colors.black),
                        right: BorderSide(color: Colors.black),
                      )),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () {
                      simpan();
                    },
                    color: Colors.redAccent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      "Simpan",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Kalilight',
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
