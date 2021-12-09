import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:login_signup_screen/restapi/restapi.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Detailevent extends StatefulWidget {
  final String nama;
  final String gambar;
  final String deskripsi;
  final String tanggalmulai;
  final String jam;
  final String tanggalselesai;
  final String jamselesai;
  final String idevent;
  const Detailevent(
      {Key key,
      this.gambar,
      this.idevent,
      this.tanggalmulai,
      this.deskripsi,
      this.nama,
      this.jam,
      this.jamselesai,
      this.tanggalselesai})
      : super(key: key);

  @override
  _DetaileventState createState() => _DetaileventState();
}

class _DetaileventState extends State<Detailevent> {
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
        number: kontakadmin,
        message:
            "Saya Ingin Bergabung dengan Event ${widget.nama}\nNama: $name1\nHP: $hp1");
  }

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
    final response = await http.post(Uri.parse(Restapi.transaksievent), body: {
      "iduser": idku,
      "idevent": widget.idevent,
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
                  'Pendaftaran Event Berhasil',
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
                kirimwas(
                    number: kontakadmin,
                    message:
                        'Pendaftaran Event\nID User : $idku \n\Nama:$name1\nHP:$hp1\n\n');
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
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .6,
            decoration: BoxDecoration(
              color: Colors.white,
              //borderRadius: BorderRadius.circular(10),
              image: new DecorationImage(
                image: NetworkImage(
                    'https://elsalvajegroup.com/public/upload/event/' +
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
            child: InkWell(
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
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(.25),
                        offset: Offset(0, 4),
                        blurRadius: 5)
                  ]),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * .6,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.2),
                      offset: Offset(0, -4),
                      blurRadius: 5,
                    )
                  ],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 40, top: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.nama,
                          style: TextStyle(fontSize: 15, fontFamily:
                                                                                'Kalilight',),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
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
                                  color: Colors.green,
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(30))),
                              height: MediaQuery.of(context).size.height / 20,
                              width: MediaQuery.of(context).size.width / 3,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.date_range,
                                        size: 15,
                                      ),
                                      Text(widget.tanggalmulai,
                                          style: TextStyle(
                                            fontSize: 10,
                                             fontFamily:
                                                                                'Kalilight',
                                            color: Colors.white,
                                          )),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.timelapse_outlined,
                                        size: 15,
                                      ),
                                      Text(widget.jam,
                                          style: TextStyle(
                                            fontSize: 10,
                                             fontFamily:
                                                                                'Kalilight',
                                            color: Colors.white,
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
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
                                  color: Colors.red,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(30))),
                              height: MediaQuery.of(context).size.height / 20,
                              width: MediaQuery.of(context).size.width / 3,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(widget.tanggalselesai,
                                            style: TextStyle(
                                              fontSize: 10,
                                               fontFamily:
                                                                                'Kalilight',
                                              color: Colors.white,
                                            )),
                                        Icon(
                                          Icons.date_range,
                                          size: 15,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(widget.jamselesai,
                                            style: TextStyle(
                                              fontSize: 10,
                                               fontFamily:
                                                                                'Kalilight',
                                              color: Colors.white,
                                            )),
                                        Icon(
                                          Icons.timelapse_outlined,
                                          size: 15,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.only(left: 40, right: 20),
                    child: Container(
                      child: ListView(
                        children: [
                          Text(
                            "Deskripsi",
                            style: TextStyle(fontSize: 15, fontFamily:
                                                                                'Kalilight',),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.deskripsi,
                            style: TextStyle( fontFamily:
                                                                                'Kalilight',),
                          )
                        ],
                      ),
                      height: MediaQuery.of(context).size.width * .8,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        simpan();
                      },
                      child: Text("Join",style: TextStyle( fontFamily:
                                                                                'Kalilight',),))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
