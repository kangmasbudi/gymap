import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:flutter_onboarding_screen/flutteronboardingscreens.dart';
import 'package:flutter_onboarding_screen/OnbordingData.dart';
import 'package:login_signup_screen/model/modelslider.dart';
import 'package:login_signup_screen/page/allevent.dart';
import 'package:login_signup_screen/page/allpaket.dart';
import 'package:login_signup_screen/page/allproduk.dart';
import 'package:login_signup_screen/page/detailpromo.dart';
import 'package:login_signup_screen/restapi/restapi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Dashboard extends StatefulWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool _isLoading = true;

  String koderef = "";
  String idku = "";
  String id = "";
  int akses;

  Future<String> getProfiles() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    id = preferences.getString("id");

    setState(() {
      _isLoading = false;
      idku = id;
      ambilpaket();
    });
  }

  var loadingpromo = false;
  final listpromo = new List<Listslider>();

  List imageList;

//menampilkan ebook dari API
  _tampil() async {
    listpromo.clear();
    setState(() {
      loadingpromo = true;
    });

    final response = await http.get(Uri.parse(Restapi.slider));
    if (response.contentLength == 2) {
    } else {
      final dataebook = jsonDecode(response.body);
      print(dataebook);
      dataebook.forEach((api) {
        final ex = new Listslider(
            api['id'], api['judul'], api['deskripsi'], api['gambar']);
        listpromo.add(ex);
      });
      setState(() {
        loadingpromo = false;
      });
    }
  }

  String name1 = "";
  String lasname1 = "";
  String hp1 = "";
  ambilpaket() async {
    final response = await http.post(Uri.parse(Restapi.getpaketku), body: {
      "id": idku,
    });

    final data = jsonDecode(response.body);

    int id = data['id'];
    String tanggalmulai = data['tanggalmulaipaket'];
    String tanggalselesai = data['tanggalselesai'];

    setState(() {
      name1 = tanggalmulai;
      lasname1 = tanggalselesai;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfiles();
    _tampil();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2.5,
                child: Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 3,
                      width: MediaQuery.of(context).size.width / 1.1,
                      decoration: BoxDecoration(
                        color: HexColor('920003'),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(40),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 80 + MediaQuery.of(context).padding.top,
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 30),
                                Text(
                                  "Membership Status",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Kalilight'),
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Starting Since:"),
                                    Text(name1),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Expires:"),
                                    Text(lasname1),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        height: MediaQuery.of(context).size.height / 4,
                        width: MediaQuery.of(context).size.width / 1.3,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(40),
                              bottomRight: Radius.circular(40)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Membership"),
                    Row(
                      children: [
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Allproduk()));
                              },
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      "Pakages",
                                      style: TextStyle(
                                          fontFamily: 'Kali',
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                height: MediaQuery.of(context).size.height / 7,
                                width: MediaQuery.of(context).size.height / 7,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    scale: 10,
                                    image: AssetImage(
                                      'assets/iconpaket.png',
                                    ),
                                  ),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                                print("E.S.Cafe");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Allmakanan()));
                              },
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      "E.S.Cafe",
                                      style: TextStyle(
                                          fontFamily: 'Kali',
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                height: MediaQuery.of(context).size.height / 7,
                                width: MediaQuery.of(context).size.height / 7,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    scale: 20,
                                    image: AssetImage(
                                      'assets/food.png',
                                    ),
                                  ),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Allevent()));
                          },
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  "Events",
                                  style: TextStyle(
                                      fontFamily: 'Kali',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            height: MediaQuery.of(context).size.height / 3.4,
                            width: MediaQuery.of(context).size.height / 3.8,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/event.png',
                                ),
                                scale: 2,
                              ),
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _vidio(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //widget slider vidio
  _vidio() {
    return Container(
      child: Column(children: [
        InkWell(
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Special Promos",
                  style: TextStyle(
                    fontFamily: 'Kalilight',
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 250,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: listpromo.length,
            itemBuilder: (context, i) {
              final d = listpromo[i];
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Detailpromo(
                                cover: d.gambar,
                                judul: d.judul,
                                deskripsi: d.deskripsi,
                              )));
                },
                child: Padding(
                  padding: EdgeInsets.all(3.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        image: new DecorationImage(
                          image: NetworkImage(
                              'https://elsalvajegroup.com/public/upload/slider/' +
                                  d.gambar,
                              scale: 6),
                          fit: BoxFit.fill,

                          //alignment: Alignment.center
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 2,
                              blurRadius: 3,
                              offset: Offset(0, 3))
                        ]),
                    margin: EdgeInsets.only(left: 10.0),
                    height: 570.0,
                    width: 150.0,
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                color: Colors.white54,
                                spreadRadius: 2,
                                blurRadius: 3,
                                offset: Offset(0, 3))
                          ]),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              d.judul,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Kali'),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )),
                  ),
                ),
              );
            },
          ),
        )
      ]),
    );
  }
}
