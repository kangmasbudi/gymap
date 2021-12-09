import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:login_signup_screen/model/modeleventcari.dart';
import 'package:login_signup_screen/model/modelpaketcari.dart';

import 'package:login_signup_screen/model/modelprodukcari.dart';
import 'package:login_signup_screen/page/detailevent.dart';

import 'package:login_signup_screen/restapi/restapi.dart';

import 'package:lottie/lottie.dart';

import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class Allevent extends StatefulWidget {
  @override
  _AlleventState createState() => _AlleventState();
}

class _AlleventState extends State<Allevent> {
  //Theme Data
  ThemeData themeData;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  //Other Variables
  bool showPassword = false;

  //UI Variables
  OutlineInputBorder allTFBorder;
  double lat;
  double lon;

  var loadingevent = false;
  final listevent = new List<Listevent>();

  var loadingdokter = false;

  List<Listevent> _list = [];
  List<Listevent> _search = [];

  tampildata() async {
    setState(() {
      loadingevent = true;
    });

    _list.clear();
    setState(() {
      loadingdokter = true;
    });

    final responsee = await http.get(Uri.parse(Restapi.event));
    if (responsee.statusCode == 200) {
      final data = jsonDecode(responsee.body);

      setState(() {
        for (Map i in data) {
          _list.add(Listevent.fromJson(i));
          loadingdokter = false;
        }
      });
    } else {
      setState(() {
        loadingdokter = false;
      });
    }
  }

  TextEditingController controller = new TextEditingController();
  _onsearch(String text) async {
    _search.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    _list.forEach((f) {
      if (f.nama.contains(text) || f.nama.contains(text)) _search.add(f);
    });
    setState(() {});
  }

  String kontakadmin = "";
  ambilnomeradmin() async {
    final response = await http.get(Uri.parse(Restapi.kontak));

    final data = jsonDecode(response.body);

    String kontak = data['kontak'];
    setState(() {
      kontakadmin = kontak;
    });
  }

  void kirimwas({@required number, @required message}) async {
    String url = "whatsapp://send?phone=$number&text=$message";
    await canLaunch(url) ? launch(url) : print("cant open whatsapp");
  }

  setuju() {
    kirimwas(number: kontakadmin, message: "kadk");
  }

  @override
  void initState() {
    super.initState();
    tampildata();
    ambilnomeradmin();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Color mainColor = HexColor('ff5252');
  _initUI() {
    allTFBorder = OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        borderSide: BorderSide(color: Colors.blue, width: 1.5));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            key: _scaffoldKey,
            appBar: new AppBar(
                leading: new IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Container(
                    decoration:
                        BoxDecoration(shape: BoxShape.circle, boxShadow: []),
                    child: new Icon(Icons.arrow_back_ios, color: Colors.white),
                  ),
                ),
                backgroundColor: mainColor,
                title: Text("All Event",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontFamily: 'Kalilight'))),
            body: ListView(
              children: [
                Container(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xffffffff),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 2,
                                color: Color(0xffb6b6b6),
                                offset: Offset(
                                  3,
                                  3,
                                ),
                              ),
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(
                              10,
                            ))),
                        height: 60,
                        padding: EdgeInsets.all(4.0),
                        margin: EdgeInsets.all(8.0),
                        child: new TextField(
                          controller: controller,
                          onChanged: _onsearch,
                          autofocus: true,
                          decoration: InputDecoration(
                              disabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              hintText: "Search For Events",
                              suffixIcon: IconButton(
                                onPressed: () {
                                  controller.clear();
                                  _onsearch('');
                                },
                                icon: Icon(Icons.search),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    style: BorderStyle.none,
                                  ))),
                        ),
                      ),
                      Container(
                          height: MediaQuery.of(context).size.height / 1.2,
                          child: loadingdokter
                              ? Center()
                              : Container(
                                  child:
                                      _search.length != 0 ||
                                              controller.text.isNotEmpty
                                          ? ListView.builder(
                                              itemCount: _search.length,
                                              itemBuilder: (context, i) {
                                                final dt = _search[i];

                                                return InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    Detailevent(
                                                                      idevent: dt
                                                                          .id
                                                                          .toString(),
                                                                      nama: dt
                                                                          .nama,
                                                                      deskripsi:
                                                                          dt.deskripsi,
                                                                      gambar: dt
                                                                          .gambar,
                                                                      jam: dt
                                                                          .jam,
                                                                      jamselesai:
                                                                          dt.jamselesai,
                                                                      tanggalmulai:
                                                                          dt.tanggalmulai,
                                                                      tanggalselesai:
                                                                          dt.tanggalselesai,
                                                                    )));
                                                  },
                                                  child: InkWell(
                                                    onTap: () {
                                                      print("asdasd");
                                                    },
                                                    child: Container(
                                                        child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: 7,
                                                        ),
                                                        InkWell(
                                                          onTap: () {},
                                                          child: Container(
                                                            height: 110,
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: Color(
                                                                        0xffffffff),
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        blurRadius:
                                                                            2,
                                                                        color: Color(
                                                                            0xffb6b6b6),
                                                                        offset:
                                                                            Offset(
                                                                          3,
                                                                          3,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(
                                                                      10,
                                                                    ))),
                                                            child: Row(
                                                              children: [
                                                                Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    image:
                                                                        new DecorationImage(
                                                                      image: NetworkImage(
                                                                          'https://elsalvajegroup.com/public/upload/event/' +
                                                                              dt
                                                                                  .gambar,
                                                                          scale:
                                                                              6),
                                                                      fit: BoxFit
                                                                          .fill,

                                                                      //alignment: Alignment.center
                                                                    ),
                                                                    color: Colors
                                                                        .redAccent,
                                                                    borderRadius: BorderRadius.only(
                                                                        topRight:
                                                                            Radius.circular(
                                                                                20),
                                                                        bottomRight:
                                                                            Radius.circular(20)),
                                                                  ),
                                                                  height: 130,
                                                                  width: 100,
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                        dt.nama,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontFamily:
                                                                              'Poppinsreguler',
                                                                        )),
                                                                    Row(
                                                                      children: [
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Row(
                                                                              children: [
                                                                                Icon(
                                                                                  Icons.date_range,
                                                                                  size: 15,
                                                                                ),
                                                                                Text(dt.tanggalmulai,
                                                                                    style: TextStyle(
                                                                                      fontSize: 10,
                                                                                      fontFamily: 'Poppinsreguler',
                                                                                      color: mainColor,
                                                                                    )),
                                                                              ],
                                                                            ),
                                                                            Row(
                                                                              children: [
                                                                                Icon(
                                                                                  Icons.timelapse_outlined,
                                                                                  size: 15,
                                                                                ),
                                                                                Text(dt.jam,
                                                                                    style: TextStyle(
                                                                                      fontSize: 10,
                                                                                      fontFamily: 'Poppinsreguler',
                                                                                      color: mainColor,
                                                                                    )),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Text(
                                                                            "  s/d  "),
                                                                        Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Row(
                                                                              children: [
                                                                                Icon(
                                                                                  Icons.date_range,
                                                                                  size: 15,
                                                                                ),
                                                                                Text(dt.tanggalselesai,
                                                                                    style: TextStyle(
                                                                                      fontSize: 10,
                                                                                      fontFamily: 'Poppinsreguler',
                                                                                      color: mainColor,
                                                                                    )),
                                                                              ],
                                                                            ),
                                                                            Row(
                                                                              children: [
                                                                                Icon(
                                                                                  Icons.timelapse_outlined,
                                                                                  size: 15,
                                                                                ),
                                                                                Text(dt.jamselesai,
                                                                                    style: TextStyle(
                                                                                      fontSize: 10,
                                                                                      fontFamily: 'Poppinsreguler',
                                                                                      color: mainColor,
                                                                                    )),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )),
                                                  ),
                                                );
                                              })
                                          : ListView.builder(
                                              itemCount: _list.length,
                                              itemBuilder: (context, i) {
                                                final dr = _list[i];

                                                return InkWell(
                                                  onTap: () {
                                                    print("asdasd");
                                                  },
                                                  child: Container(
                                                      child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        height: 7,
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          Detailevent(
                                                                            idevent:
                                                                                dr.id.toString(),
                                                                            nama:
                                                                                dr.nama,
                                                                            deskripsi:
                                                                                dr.deskripsi,
                                                                            gambar:
                                                                                dr.gambar,
                                                                            jam:
                                                                                dr.jam,
                                                                            jamselesai:
                                                                                dr.jamselesai,
                                                                            tanggalmulai:
                                                                                dr.tanggalmulai,
                                                                            tanggalselesai:
                                                                                dr.tanggalselesai,
                                                                          )));
                                                        },
                                                        child: Container(
                                                          height: 110,
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: Color(
                                                                      0xffffffff),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      blurRadius:
                                                                          2,
                                                                      color: Color(
                                                                          0xffb6b6b6),
                                                                      offset:
                                                                          Offset(
                                                                        3,
                                                                        3,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius
                                                                              .circular(
                                                                    10,
                                                                  ))),
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  image:
                                                                      new DecorationImage(
                                                                    image: NetworkImage(
                                                                        'https://elsalvajegroup.com/public/upload/event/' +
                                                                            dr.gambar,
                                                                        scale: 6),
                                                                    fit: BoxFit
                                                                        .fill,

                                                                    //alignment: Alignment.center
                                                                  ),
                                                                  color: Colors
                                                                      .redAccent,
                                                                  borderRadius: BorderRadius.only(
                                                                      topRight:
                                                                          Radius.circular(
                                                                              20),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              20)),
                                                                ),
                                                                height: 130,
                                                                width: 100,
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(dr.nama,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        fontFamily:
                                                                            'Poppinsreguler',
                                                                      )),
                                                                  Row(
                                                                    children: [
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Row(
                                                                            children: [
                                                                              Icon(
                                                                                Icons.date_range,
                                                                                size: 15,
                                                                              ),
                                                                              Text(dr.tanggalmulai,
                                                                                  style: TextStyle(
                                                                                    fontSize: 10,
                                                                                    fontFamily: 'Poppinsreguler',
                                                                                    color: mainColor,
                                                                                  )),
                                                                            ],
                                                                          ),
                                                                          Row(
                                                                            children: [
                                                                              Icon(
                                                                                Icons.timelapse_outlined,
                                                                                size: 15,
                                                                              ),
                                                                              Text(dr.jam,
                                                                                  style: TextStyle(
                                                                                    fontSize: 10,
                                                                                    fontFamily: 'Poppinsreguler',
                                                                                    color: mainColor,
                                                                                  )),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Text(
                                                                          "  s/d  "),
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Row(
                                                                            children: [
                                                                              Icon(
                                                                                Icons.date_range,
                                                                                size: 15,
                                                                              ),
                                                                              Text(dr.tanggalselesai,
                                                                                  style: TextStyle(
                                                                                    fontSize: 10,
                                                                                    fontFamily: 'Poppinsreguler',
                                                                                    color: mainColor,
                                                                                  )),
                                                                            ],
                                                                          ),
                                                                          Row(
                                                                            children: [
                                                                              Icon(
                                                                                Icons.timelapse_outlined,
                                                                                size: 15,
                                                                              ),
                                                                              Text(dr.jamselesai,
                                                                                  style: TextStyle(
                                                                                    fontSize: 10,
                                                                                    fontFamily: 'Poppinsreguler',
                                                                                    color: mainColor,
                                                                                  )),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                                );
                                              })))
                      //Column(children: newsList)
                    ],
                  ),
                )
              ],
            )));
  }

  void showMessage({String message = "Something wrong", Duration duration}) {
    if (duration == null) {
      duration = Duration(seconds: 3);
    }
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        duration: duration,
        content: Text(
          message,
        ),
        backgroundColor: themeData.colorScheme.primary,
        behavior: SnackBarBehavior.fixed,
      ),
    );
  }
}
