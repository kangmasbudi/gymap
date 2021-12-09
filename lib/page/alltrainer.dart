import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:login_signup_screen/model/modelpaketcari.dart';

import 'package:login_signup_screen/model/modelprodukcari.dart';
import 'package:login_signup_screen/model/modeltrainercari.dart';
import 'package:login_signup_screen/page/detailpaket.dart';

import 'package:login_signup_screen/restapi/restapi.dart';

import 'package:lottie/lottie.dart';

import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'konfirmasidengantrainer.dart';

class Alltrainer extends StatefulWidget {
  final String nama;
  final String gambar;
  final String deskripsi;
  final int id;
  final String jumlahhari;
  final String harga;

  const Alltrainer(
      {Key key,
      this.nama,
      this.gambar,
      this.deskripsi,
      this.id,
      this.jumlahhari,
      this.harga})
      : super(key: key);
  @override
  _AlltrainerState createState() => _AlltrainerState();
}

class _AlltrainerState extends State<Alltrainer> {
  //Theme Data
  ThemeData themeData;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  //Other Variables
  bool showPassword = false;

  //UI Variables
  OutlineInputBorder allTFBorder;
  double lat;
  double lon;

  var loadingpaket = false;
  final listpaket = new List<Listtrainer>();

  var loadingdokter = false;

  List<Listtrainer> _list = [];
  List<Listtrainer> _search = [];

  tampildata() async {
    setState(() {
      loadingpaket = true;
    });

    _list.clear();
    setState(() {
      loadingdokter = true;
    });

    final responsee = await http.get(Uri.parse(Restapi.trainer));
    if (responsee.statusCode == 200) {
      final data = jsonDecode(responsee.body);
      print(data);
      setState(() {
        for (Map i in data) {
          _list.add(Listtrainer.fromJson(i));
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
    kirimwas(
        number: kontakadmin,
        message: "Hallo Admin Best DMR Eco Racing Saya Ingin Bertanya?");
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

  Color mainColor = HexColor('920003');
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
                title: Text("Daftar Trainer",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                       fontFamily:
                                                                                'Kalilight',
                    ))),
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
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
                                hintText: "Cari Trainer",
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
                                                    onTap: () {},
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
                                                                            Konfirmasitrainer(
                                                                              deskripsi: widget.deskripsi,
                                                                              gambar: widget.gambar,
                                                                              harga: widget.harga,
                                                                              id: widget.id,
                                                                              jumlahhari: widget.jumlahhari,
                                                                              nama: widget.nama,
                                                                              tarif: dt.tarif,
                                                                              namatrainer: dt.nama,
                                                                              idtrainer: dt.id.toString(),
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
                                                                          'https://elsalvajegroup.com/public/upload/triner/' +
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
                                                                  width: 80,
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
                                                                      "Nama Trainer",
                                                                      style: TextStyle(
                                                                         fontFamily:
                                                                                'Kalilight',
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                    Text(
                                                                        dt.nama,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                         fontFamily:
                                                                                'Kalilight',
                                                                          color:
                                                                              mainColor,
                                                                        )),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                          NumberFormat.currency(locale: 'id', decimalDigits: 0)
                                                                              .format(int.parse(dt.tarif)),
                                                                          style: TextStyle(
                                                                            fontFamily:
                                                                                'Kalilight',
                                                                              fontSize: 15),
                                                                        ),
                                                                        Text(
                                                                            "/Bulan")
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Icon(Icons
                                                                            .phone),
                                                                        Text(dt
                                                                            .hp),
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )),
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
                                                                            Konfirmasitrainer(
                                                                              deskripsi: widget.deskripsi,
                                                                              gambar: widget.gambar,
                                                                              harga: widget.harga,
                                                                              id: widget.id,
                                                                              jumlahhari: widget.jumlahhari,
                                                                              nama: widget.nama,
                                                                              tarif: dr.tarif,
                                                                              namatrainer: dr.nama,
                                                                              idtrainer: dr.id.toString(),
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
                                                                          'https://elsalvajegroup.com/public/upload/triner/' +
                                                                              dr
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
                                                                  width: 80,
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
                                                                      "Nama Trainer",
                                                                      style: TextStyle(
                                                                         fontFamily:
                                                                                'Kalilight',
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                    Text(
                                                                        dr.nama,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                         fontFamily:
                                                                                'Kalilight',
                                                                          color:
                                                                              mainColor,
                                                                        )),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                          NumberFormat.currency(locale: 'id', decimalDigits: 0)
                                                                              .format(int.parse(dr.tarif)),
                                                                          style: TextStyle(
                                                                             fontFamily:
                                                                                'Kalilight',
                                                                              fontSize: 15),
                                                                        ),
                                                                        Text(
                                                                            "/Bulan")
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Icon(Icons
                                                                            .phone),
                                                                        Text(dr
                                                                            .hp),
                                                                      ],
                                                                    )
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
