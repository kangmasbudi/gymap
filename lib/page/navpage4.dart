import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:login_signup_screen/model/modelriwayatpaket.dart';
import 'package:login_signup_screen/page/editprofil.dart';
import 'package:login_signup_screen/restapi/restapi.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Navpage4 extends StatefulWidget {
  const Navpage4({Key key}) : super(key: key);

  @override
  _Navpage4State createState() => _Navpage4State();
}

class _Navpage4State extends State<Navpage4> {
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
      ambildata();
      tampilriwayatpaket();
    });
  }

  String name1 = "";
  String lasname1 = "";
  String hp1 = "";
  String gender1 = "";
  String email1 = "";
  ambildata() async {
    final response = await http.post(Uri.parse(Restapi.getprofil), body: {
      "id": idku,
    });

    final data = jsonDecode(response.body);

    int id = data['id'];
    String name = data['name'];
    String lastname = data['lastname'];
    String hp = data['hp'];
    String email = data['email'];
    String gender = data['gender'];

    setState(() {
      name1 = name;
      lasname1 = lastname;
      hp1 = hp;
      email1 = email;
      gender1 = gender;
    });
  }

  var loading = false;
  final listvidio = new List<Listriwayatpaket>();

  tampilriwayatpaket() async {
    setState(() {
      loading = true;
      listvidio.clear();
    });
    final response = await http.post(Uri.parse(Restapi.riwayatpaket), body: {
      "id": idku,
    });
    if (response.contentLength == 2) {
    } else {
      final data = jsonDecode(response.body);
      print(data);
      data.forEach((api) {
        final exp = new Listriwayatpaket(api['id'], api['tanggalmulaipaket'],
            api['tanggalselesai'], api['total']);
        listvidio.add(exp);
      });
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfiles();
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
                        color: Colors.redAccent,
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
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Profil Member",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Editprofil(
                                                        id: idku,
                                                        email: email1,
                                                        gender: gender1,
                                                        hp: hp1,
                                                        lastname: lasname1,
                                                        name: name1)));
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                      ),
                                    )
                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Nama :"),
                                    Text(name1),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Nama Akhir :"),
                                    Text(lasname1),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [Text("HP/Wa"), Text(hp1)],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Jenis kelamin"),
                                    Text(gender1)
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [Text("Email"), Text(email1)],
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
              Text(
                "Riwayat Paket Yang Pernah",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Divider(),
              Container(
                child: loading
                    ? Center(
                        child: Text("Anda Belum Punya Riwayat Paket Gym"),
                      )
                    : ListView.builder(
                        itemCount: listvidio.length,
                        itemBuilder: (context, i) {
                          final x = listvidio[i];
                          return Card(
                            child: ListTile(
                              trailing: Text(
                                NumberFormat.currency(
                                        locale: 'id', decimalDigits: 0)
                                    .format(int.parse(x.total)),
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              title: Text("Paket Gym"),
                              subtitle: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text("Tanggal Mulai :"),
                                      Text(x.tanggalmulaipaket),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Tanggal Selesai :"),
                                      Text(x.tanggalmulaipaket),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                height: MediaQuery.of(context).size.height / 2,
              )
            ],
          ),
        ),
      ),
    );
  }
}
