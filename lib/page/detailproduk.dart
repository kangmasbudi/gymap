import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:intl/intl.dart';
import 'package:login_signup_screen/page/alltrainer.dart';
import 'package:login_signup_screen/page/konfirmasi.dart';
import 'package:login_signup_screen/restapi/restapi.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class Detailproduk extends StatefulWidget {
  final String nama;
  final String gambar;
  final String deskripsi;
  final int id;

  final String harga;

  const Detailproduk({
    Key key,
    this.gambar,
    this.id,
    this.deskripsi,
    this.nama,
    this.harga,
  }) : super(key: key);

  @override
  _DetailprodukState createState() => _DetailprodukState();
}

class _DetailprodukState extends State<Detailproduk> {
  Color mainColor = HexColor('920003');

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
        number: kontakadmin, message: "Saya Ingin Berlangganan Member Paket");
  }

  int qty = 1;

  String name1 = "";
  String lasname1 = "";
  String hp1 = "";
  ambildata() async {
    final response = await http.post(Uri.parse(Restapi.getprofil), body: {
      "id": idku,
    });

    final data = jsonDecode(response.body);

    int id = data['id'];
    String name = data['name'];
    String lastname = data['lastname'];
    String hp = data['hp'];

    setState(() {
      name1 = name;
      lasname1 = lastname;
      hp1 = hp;
    });
  }

  String idku = "";
  String id = "";
  bool _isLoading = true;
  int grantotal = 0;
  Future<String> getProfiles() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    id = preferences.getString("id");

    setState(() {
      _isLoading = false;
      idku = id;
      print("ini ID Ku");
      print(idku);
      ambildata();
    });
  }

  simpan() async {
    // print(idku);
    print(widget.id);
    print(qty);
    //print(widget.harga);

    final response = await http.post(Uri.parse(Restapi.tempkeranjang), body: {
      "iduser": idku.toString(),
      "idproduk": widget.id.toString(),
      "qty": qty.toString(),
      "hargasatuan": widget.harga.toString(),
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
                  'Keranjang Berhasil di tambah',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);
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
    ambilnomeradmin();
    getProfiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .4,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    //borderRadius: BorderRadius.circular(10),
                    image: new DecorationImage(
                      image: NetworkImage(
                          'https://elsalvajegroup.com/public/upload/product/' +
                              widget.gambar,
                          scale: 6),
                      fit: BoxFit.fill,

                      //alignment: Alignment.center
                    ),
                  ),
                ),
                Positioned(
                  left: 30,
                  top: 10 + MediaQuery.of(context).padding.top,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: ClipOval(
                          child: Container(
                            child: Center(
                              child: Icon(Icons.arrow_back_rounded),
                            ),
                            height: 42,
                            width: 42,
                            decoration:
                                BoxDecoration(color: Colors.white, boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(.25),
                                  offset: Offset(0, 4),
                                  blurRadius: 5)
                            ]),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.nama,
                        style: TextStyle(
                          fontFamily: 'Kalilight',
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: 240 + MediaQuery.of(context).padding.top,
                  left: 30,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  NumberFormat.currency(
                                          locale: 'id', decimalDigits: 0)
                                      .format(int.parse(widget.harga)),
                                  style: TextStyle(
                                      fontFamily: 'Kalilight', fontSize: 25),
                                ),
                              ],
                            ),
                          ),
                          //height: 50,
                          height: MediaQuery.of(context).size.height / 9,
                          width: MediaQuery.of(context).size.width / 1.2,

                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(.25),
                                    offset: Offset(0, 4),
                                    blurRadius: 5)
                              ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 3,
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: ListView(children: [Text(widget.deskripsi)]),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    qty = qty - 1;
                  });
                },
                child: Container(
                  child: Center(
                    child: Text(
                      "-",
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadiusDirectional.circular(15),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(.25),
                            offset: Offset(0, 4),
                            blurRadius: 5)
                      ]),
                  height: MediaQuery.of(context).size.height / 14,
                  width: MediaQuery.of(context).size.width / 6,
                ),
              ),
              Container(
                child: Center(
                  child: Text(
                    qty.toString(),
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                height: MediaQuery.of(context).size.height / 14,
                width: MediaQuery.of(context).size.width / 4,
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadiusDirectional.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(.25),
                          offset: Offset(0, 4),
                          blurRadius: 5)
                    ]),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    qty = qty + 1;
                  });
                },
                child: Container(
                  child: Center(
                    child: Text(
                      "+",
                      style: TextStyle(fontFamily: 'Kalilight', fontSize: 25),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadiusDirectional.circular(15),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(.25),
                            offset: Offset(0, 4),
                            blurRadius: 5)
                      ]),
                  height: MediaQuery.of(context).size.height / 14,
                  width: MediaQuery.of(context).size.width / 6,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  simpan();
                },
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Row(
                        children: [
                          Icon(Icons.shopping_cart),
                          Text("Tambah Keranjang",style:TextStyle( fontFamily:
                                                                                'Kalilight',)),
                        ],
                      ),
                    ),
                  ),
                  height: 50,
                  width: MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.red, width: 3),
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
