import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:intl/intl.dart';
import 'package:login_signup_screen/restapi/restapi.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class Konfirmasitrainer extends StatefulWidget {
  final String nama;
  final String gambar;
  final String deskripsi;
  final int id;
  final String jumlahhari;
  final String harga;
  final String idtrainer;
  final String tarif;
  final String namatrainer;

  const Konfirmasitrainer(
      {Key key,
      this.gambar,
      this.id,
      this.deskripsi,
      this.namatrainer,
      this.nama,
      this.harga,
      this.idtrainer,
      this.tarif,
      this.jumlahhari})
      : super(key: key);

  @override
  _KonfirmasitrainerState createState() => _KonfirmasitrainerState();
}

class _KonfirmasitrainerState extends State<Konfirmasitrainer> {
  Color mainColor = HexColor('ff5252');

  String idku = "";
  String id = "";
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

  bool _isLoading = true;
  String koderef = "";

  int akses;

  String kontakadmin = "";

  ambilnomeradmin() async {
    final response = await http.get(Uri.parse(Restapi.kontak));

    final data = jsonDecode(response.body);

    String kontak = data['kontak'];
    setState(() {
      kontakadmin = kontak;
    });
  }

  ambilnomerrekening() async {
    final response = await http.get(Uri.parse(Restapi.tampilrekening));

    final data = jsonDecode(response.body);

    String a = data['bank'];
    String b = data['rekening'];
    String c = data['atasnama'];
    setState(() {
      bank = a;
      atasnama = c;
      norekening = b;
    });

    print(bank);
  }

  String norekening = "";
  String atasnama = "";
  String bank = "";

  void kirimwas({@required number, @required message}) async {
    String url = "whatsapp://send?phone=$number&text=$message";
    await canLaunch(url) ? launch(url) : print("cant open whatsapp");
  }

  setuju() {
    kirimwas(
        number: kontakadmin, message: "Saya Ingin Berlangganan Member Paket");
  }

  simpan() async {
    print(idku);
    print(widget.jumlahhari);
    print(widget.harga);

    final response = await http.post(Uri.parse(Restapi.transaksi), body: {
      "iduser": idku,
      "idtrainer": widget.idtrainer,
      "hargatrainer": widget.tarif,
      "jumlahhari": widget.jumlahhari,
      "hargapaket": widget.harga,
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
                  'Pendaftaran Member Berhasil dan akan di verifikasi,',
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
                        'Pendaftaran Member Paket Gym\nID User : $idku \n\Nama:$name1\nHP:$hp1\n\nMasa: ${widget.jumlahhari}/Hari\nLampirkan Bukti Transfer agar dapat di proses lebih lanjut');
              },
            ),
          ],
        );
      },
    );
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ambilnomeradmin();
    getProfiles();
    ambilnomerrekening();
    print("ini Jumlah hari trainer");
    print(widget.jumlahhari);
    setState(() {
      grantotal = int.parse('${widget.tarif}') + int.parse('${widget.harga}');
    });
    print(grantotal);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: mainColor,
        title: Text(
          "Konfirmasi Trainer",
          style: TextStyle(fontSize: 15,fontFamily: 'Kali'),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                height: MediaQuery.of(context).size.height / 1.1,
                decoration: BoxDecoration(
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
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Anda akan berlangganan paket:",style: TextStyle( fontFamily:
                                                                                'Kalilight',)),
                      Text(widget.nama,style: TextStyle( fontFamily:
                                                                                'Kalilight',)),
                      Divider(),
                      Text(
                          "Masa Aktif Member akan otomatis tarcantum di halaman dashboard anda, dan silahkan membayar ke rekening yang ada di bawah ini dan silahkan konfirmasi melalui WhatsApp Ke Admin dengan melampilkan bukti transfer",style: TextStyle( fontFamily:
                                                                                'Kalilight',)),
                      SizedBox(
                        height: 30,
                      ),
                      Text("Pembayaran Biaya Langganan Ke...!",style: TextStyle( fontFamily:
                                                                                'Kalilight',)),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text("Nama Bank",style: TextStyle( fontFamily:
                                                                                'Kalilight',)), Text(bank,style: TextStyle( fontFamily:
                                                                                'Kalilight',))],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text("Atas Nama",style: TextStyle( fontFamily:
                                                                                'Kalilight',)), Text(atasnama,style: TextStyle( fontFamily:
                                                                                'Kalilight',))],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text("No Rekening",style: TextStyle( fontFamily:
                                                                                'Kalilight',)), Text(norekening,style: TextStyle( fontFamily:
                                                                                'Kalilight',))],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text("Total Paket",style: TextStyle( fontFamily:
                                                                                'Kalilight',)),
                      Text(
                        NumberFormat.currency(locale: 'id', decimalDigits: 0)
                            .format(int.parse(widget.harga)),
                        style: TextStyle(
                            fontFamily: 'Kali',
                            fontSize: 15,
                            color: Colors.red),
                      ),
                      Text("Total Trainer",style: TextStyle( fontFamily:
                                                                                'Kalilight',)),
                      Row(
                        children: [
                          Text(
                            NumberFormat.currency(
                                    locale: 'id', decimalDigits: 0)
                                .format(int.parse(widget.tarif)),
                            style: TextStyle(
                                fontFamily: 'Kali',
                                fontSize: 15,
                                color: Colors.red),
                          ),
                          Text("(${widget.namatrainer})",style: TextStyle( fontFamily:
                                                                                'Kalilight',))
                        ],
                      ),
                      Divider(),
                      Text("Grand Total",style: TextStyle( fontFamily:
                                                                                'Kalilight',)),
                      Row(
                        children: [
                          Text(
                            NumberFormat.currency(
                                    locale: 'id', decimalDigits: 0)
                                .format(grantotal),
                            style:
                                TextStyle(fontFamily: 'Kali', fontSize: 25),
                          ),
                        ],
                      ),
                      ElevatedButton(
                          onPressed: () {
                            simpan();
                          },
                          child: Text("Click",style: TextStyle( fontFamily:
                                                                                'Kalilight',)))
                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }
}
