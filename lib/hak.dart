import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login_signup_screen/restapi/restapi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class Hak extends StatefulWidget {
  const Hak({Key key}) : super(key: key);

  @override
  _HakState createState() => _HakState();
}

class _HakState extends State<Hak> {
  String id = "";
  String idku = "";
  String name = "";
  String email = "";
  String phoneno = "";

  ThemeData themeData;

  bool _isLoading = true;

  String koderef = "";

  int akses;
  String name1 = "";
  //String email = "";
  String hp = "";
  String status = "";
  String koderefku = "";
  String namaku = "";
  // String idku = "";
  String jenengku = "";
  String emailnyo = "";
  String hpnyo = "";
  String alamatnyo = "";
  String jabatan = "";
  String iconcompany = "";

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

  Future<String> getProfiles() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    id = preferences.getString("id");

    setState(() {
      _isLoading = false;
      idku = id;
      print("ini halaman hak");
      print(idku);
    });
     ambildata();
/*
    setState(() {
      _isLoading = false;

      if (status == "0") {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => BottomNavigation2Page()));
      } else if (status == "2") {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => BottomNavigation2PageJendral()));
      } else if (status == "1") {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => BottomNavigation2PagePrajurit()));
      }
    });


    */
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
