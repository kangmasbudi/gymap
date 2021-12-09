import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login_signup_screen/page/Dashboard.dart';
import 'package:login_signup_screen/page/bottom_navbar.dart';

import 'package:login_signup_screen/restapi/restapi.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'hak.dart';
import 'spalsh.dart';
import 'package:http/http.dart' as http;

class Wrapper extends StatefulWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  String id = "";
  String name1 = "";
  String email = "";
  String hp = "";
  String status = "";
  String koderefku = "";
  String namaku = "";
  String idku = "";
  String jenengku = "";
  String emailnyo = "";
  String hpnyo = "";
  String alamatnyo = "";
  String jabatan = "";
  String iconcompany = "";

  ambiliconcompany() async {
    final response = await http.get(Uri.parse(Restapi.getprofil));
    final dataiconcompany = jsonDecode(response.body);
    String iconc = dataiconcompany['gambar'];
    setState(() {
      iconcompany = iconc;
    });
  }

  ambildata() async {
    final response = await http.post(Uri.parse(Restapi.getprofil), body: {
      "id": idku,
    });

    final data = jsonDecode(response.body);

    int id = data['id'];
    String koderef = data['koderef'];
    String koderefteman = data['koderefteman'];
    String status = data['status'];
    String jeneng = data['name'];
    String emailnya = data['email'];
    String hpnya = data['hp'];
    String alamat = data['alamat'];

    setState(() {
      koderefku = koderef;
      emailnyo = emailnya;
      hpnyo = hpnya;
      alamatnyo = alamat;
      jenengku = jeneng;

  
    });
  }

  bool _isLoading = true;

  String koderef = "";

  int akses;

  Future<String> getProfiles() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    id = preferences.getString("id");

    setState(() {
      _isLoading = false;
      idku = id;
      print(idku);
    });
 
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfiles();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? CircularProgressIndicator()
        : idku != null
            ? BottomNavigation2Page()
            : Spash();
  }
}
