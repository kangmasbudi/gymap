import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:login_signup_screen/model/modelpaketcari.dart';

import 'package:login_signup_screen/model/modelprodukcari.dart';
import 'package:login_signup_screen/model/modeltempbelanja.dart';
import 'package:login_signup_screen/page/detailpaket.dart';

import 'package:login_signup_screen/restapi/restapi.dart';

import 'package:lottie/lottie.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Allkeranjangku extends StatefulWidget {
  final String gambar;
  final String deskripsi;
  final int id;
  final String jumlahhari;
  final String harga;

  const Allkeranjangku(
      {Key key,
      this.gambar,
      this.deskripsi,
      this.id,
      this.jumlahhari,
      this.harga})
      : super(key: key);

  @override
  _AllkeranjangkuState createState() => _AllkeranjangkuState();
}

class _AllkeranjangkuState extends State<Allkeranjangku> {
  //Theme Data
  ThemeData themeData;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  //Other Variables
  bool showPassword = false;

  //UI Variables
  OutlineInputBorder allTFBorder;
  double lat;
  double lon;

  String name1 = "";
  String lasname1 = "";
  String hp1 = "";
  int totalbelanja = 0;

  _hapuskeranjang(String idbarang) async {
    final response = await http.post(Uri.parse(Restapi.hapusbelanja), body: {
      "id": idbarang,
    });
    final data = jsonDecode(response.body);
    print(data);
    String value = data['value'];
    String pesan = data['message'];
    if (value == "1") {
      print("barang berahsil di hapus ");
      _pesan();
    } else {
      print(print);
    }
  }

  total() async {
    final response =
        await http.post(Uri.parse(Restapi.totalkeranjangku), body: {
      "iduser": idku,
    });

    final data = jsonDecode(response.body);
    print(data);
    int tot = data['message'];

    setState(() {
      totalbelanja = tot;
    });

    print("ini total belanjaku");
    print(totalbelanja);
  }

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
      tampildatabelanja();
      total();
    });
  }

  var loading = false;
  final listvidio = new List<Listtempbelanja>();

  tampildatabelanja() async {
    setState(() {
      loading = true;
      listvidio.clear();
    });
    final response = await http.post(Uri.parse(Restapi.tempkeranjangku), body: {
      "iduser": idku,
    });
    if (response.contentLength == 2) {
    } else {
      final data = jsonDecode(response.body);
      print(data);
      data.forEach((api) {
        final exp = new Listtempbelanja(
            api['id'], api['namabarang'], api['qty'], api['total']);
        listvidio.add(exp);
      });
      setState(() {
        loading = false;
      });
    }
  }

  TextEditingController controller = new TextEditingController();

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

  Future<void> _pesanberhasil() async {
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
                  'Pesanan Anda Akan Segera di proses',
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
                tampildatabelanja();
                total();
                kirimwas(
                    number: kontakadmin,
                    message: 'Pesanan Atasnama:$name1 Nomor Pesan : $nopesan');
              },
            ),
          ],
        );
      },
    );
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
                  'Keranjang Berhasil di hapus',
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
                tampildatabelanja();
                total();
              },
            ),
          ],
        );
      },
    );
  }

  String nopesan = "";
  simpan() async {
    // print(idku);
    print(widget.id);

    //print(widget.harga);

    final response = await http.post(Uri.parse(Restapi.bayar), body: {
      "id": idku.toString(),
      "grandtotal": totalbelanja.toString(),
    });

    final data = jsonDecode(response.body);
    String value = data['value'];
    String nocash = data['notransaksi'];
    String pesan = data['message'];
    if (value == "1") {
      setState(() {
        nopesan = nocash;
      });
      _pesanberhasil();

      print(nocash);
    } else {
      print(print);
    }
  }

  @override
  void initState() {
    super.initState();

    ambilnomeradmin();
    getProfiles();
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
                title: Text("Keranjang Ku",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ))),
            body: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 1.5,
                  child: loading
                      ? Center(child: Text("Keranjang Anda Kosong"))
                      : ListView.builder(
                          itemCount: listvidio.length,
                          itemBuilder: (context, i) {
                            final x = listvidio[i];
                            return Card(
                              child: ListTile(
                                title: Text(x.namabarang),
                                leading: InkWell(
                                    onTap: () {
                                      _hapuskeranjang(x.id.toString());
                                    },
                                    child: Icon(Icons.delete_forever)),
                                subtitle: Row(
                                  children: [
                                    Text('Total=  '),
                                    Text(
                                      NumberFormat.currency(
                                              locale: 'id', decimalDigits: 0)
                                          .format(int.parse(x.total)),
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 6.7,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(.25),
                            offset: Offset(1, 4),
                            blurRadius: 5)
                      ],
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 7,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Total Belanja=   ",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                          Text(
                              NumberFormat.currency(
                                      locale: 'id', decimalDigits: 0)
                                  .format(int.parse(
                                totalbelanja.toString(),
                              )),
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                        ],
                      ),
                      ElevatedButton(
                          onPressed: () {
                            simpan();
                          },
                          child: Text("ChecOut"))
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
