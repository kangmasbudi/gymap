import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:intl/intl.dart';
import 'package:login_signup_screen/page/alltrainer.dart';
import 'package:login_signup_screen/page/konfirmasi.dart';
import 'package:login_signup_screen/restapi/restapi.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class Detailpaket extends StatefulWidget {
  final String nama;
  final String gambar;
  final String deskripsi;
  final int id;
  final String jumlahhari;
  final String harga;

  const Detailpaket(
      {Key key,
      this.gambar,
      this.id,
      this.deskripsi,
      this.nama,
      this.harga,
      this.jumlahhari})
      : super(key: key);

  @override
  _DetailpaketState createState() => _DetailpaketState();
}

class _DetailpaketState extends State<Detailpaket> {
  Color mainColor = HexColor('ff5252');

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ambilnomeradmin();
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
                          'https://elsalvajegroup.com/public/upload/paket/' +
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
                      Text(widget.nama,style: TextStyle( fontFamily:
                                                                                'Kalilight',),)
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
                                       fontFamily:
                                                                                'Kalilight', fontSize: 25),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "/",
                                      style: TextStyle(
                                           fontFamily:
                                                                                'Kalilight', fontSize: 25),
                                    ),
                                    Text(
                                      widget.jumlahhari,
                                      style: TextStyle(
                                           fontFamily:
                                                                                'Kalilight', fontSize: 25),
                                    ),
                                    Text(
                                      "Hari",
                                      style: TextStyle(
                                           fontFamily:
                                                                                'Kalilight', fontSize: 25),
                                    ),
                                  ],
                                )
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
            height: MediaQuery.of(context).size.height / 2.3,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: ListView(children: [Text(widget.deskripsi)]),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Konfirmasi(
                                deskripsi: widget.deskripsi,
                                gambar: widget.gambar,
                                harga: widget.harga,
                                id: widget.id,
                                jumlahhari: widget.jumlahhari,
                                nama: widget.nama,
                              )));
                },
                child: Container(
                  child: Center(
                    child: Text("Tanpa Trainer",style: TextStyle( fontFamily:
                                                                                'Kalilight',),),
                  ),
                  height: 50,
                  width: MediaQuery.of(context).size.width / 2.5,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.red, width: 3),
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Alltrainer(
                                deskripsi: widget.deskripsi,
                                gambar: widget.gambar,
                                harga: widget.harga,
                                id: widget.id,
                                jumlahhari: widget.jumlahhari,
                                nama: widget.nama,
                              )));
                },
                child: Container(
                  child: Center(
                    child: Text("Dengan Trainer",style: TextStyle( fontFamily:
                                                                                'Kalilight',),),
                  ),
                  height: 50,
                  width: MediaQuery.of(context).size.width / 2.5,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.green, width: 3),
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
