import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:login_signup_screen/auth/log.dart';

import 'package:login_signup_screen/restapi/restapi.dart';
import 'package:lottie/lottie.dart';

class Register extends StatefulWidget {
  const Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //Text Field Editing Controller
  TextEditingController nameTFController;
  TextEditingController emailTFController;
  TextEditingController passwordTFController;
  TextEditingController phone;

  //Global Keys
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  //Other Variables
  bool showPassword = false;
  bool showPassword1 = false;
  TextEditingController hpcontroller = new TextEditingController();
  TextEditingController namacontroller = new TextEditingController();
  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();
  TextEditingController ulangipasswordcontroller = new TextEditingController();
  TextEditingController kodereftemancontroller = new TextEditingController();

  simpan() async {
    if (passwordcontroller.text != ulangipasswordcontroller.text) {
      _pesanpassword();
    } else {
      login();
    }
  }

  login() async {
    final response = await http.post(Uri.parse(Restapi.registrasi), body: {
      "name": namacontroller.text,
      "email": emailcontroller.text,
      "password": passwordcontroller.text,
      "hp": hpcontroller.text,
      "koderefteman": kodereftemancontroller.text,
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

//menampilkan pesan jika password tidak sama

  Future<void> _pesanpassword() async {
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
                  'Password tidak sama',
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

  //menampilkan pesan saat registrasi berhasil

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
                  'Selamat Pendaftaran Ada Berhasil Silahkan Login dengan Email Dan Password',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Login()));
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
    namacontroller.text = "";
    hpcontroller.text = "";
    passwordcontroller.text = "";
    emailcontroller.text = "";
    kodereftemancontroller.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.black,
            ),
          ),
        ),
        key: _scaffoldKey,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            height: MediaQuery.of(context).size.height - 50,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      "Registrasi",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Silahkan Daftar Gratis",
                      style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    //

                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Nama",
                        style: TextStyle(fontSize: 15),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Color(0xffffffff),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 1,
                              color: Color(0xff737373),
                              offset: Offset(
                                2,
                                2,
                              ),
                            ),
                          ],
                          gradient: null,
                          borderRadius: BorderRadius.all(Radius.circular(
                            7,
                          ))),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: namacontroller,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[400]),
                            ),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey[400]))),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Email",
                        style: TextStyle(fontSize: 15),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Color(0xffffffff),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 1,
                              color: Color(0xff737373),
                              offset: Offset(
                                2,
                                2,
                              ),
                            ),
                          ],
                          gradient: null,
                          borderRadius: BorderRadius.all(Radius.circular(
                            7,
                          ))),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailcontroller,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.mail),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[400]),
                            ),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey[400]))),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Password",
                        style: TextStyle(fontSize: 15),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Color(0xffffffff),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 1,
                              color: Color(0xff737373),
                              offset: Offset(
                                2,
                                2,
                              ),
                            ),
                          ],
                          gradient: null,
                          borderRadius: BorderRadius.all(Radius.circular(
                            7,
                          ))),
                      child: TextFormField(
                        controller: passwordcontroller,
                        obscureText: !showPassword1,
                        decoration: InputDecoration(
                            suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  showPassword1 = !showPassword1;
                                });
                              },
                              child: Icon(
                                showPassword1
                                    ? Icons.remove_red_eye
                                    : Icons.remove_outlined,
                              ),
                            ),
                            prefixIcon: Icon(Icons.lock),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[400]),
                            ),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey[400]))),
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Ulangi Password",
                        style: TextStyle(fontSize: 15),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Color(0xffffffff),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 1,
                              color: Color(0xff737373),
                              offset: Offset(
                                2,
                                2,
                              ),
                            ),
                          ],
                          gradient: null,
                          borderRadius: BorderRadius.all(Radius.circular(
                            7,
                          ))),
                      child: TextFormField(
                        controller: ulangipasswordcontroller,
                        obscureText: !showPassword,
                        decoration: InputDecoration(
                            suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  showPassword = !showPassword;
                                });
                              },
                              child: Icon(
                                showPassword
                                    ? Icons.remove_red_eye
                                    : Icons.remove_outlined,
                              ),
                            ),
                            prefixIcon: Icon(Icons.lock),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[400]),
                            ),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey[400]))),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "HP/Wa",
                        style: TextStyle(fontSize: 15),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Color(0xffffffff),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 1,
                              color: Color(0xff737373),
                              offset: Offset(
                                2,
                                2,
                              ),
                            ),
                          ],
                          gradient: null,
                          borderRadius: BorderRadius.all(Radius.circular(
                            7,
                          ))),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: hpcontroller,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.phone),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[400]),
                            ),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey[400]))),
                      ),
                    ),

                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Kode Referal",
                        style: TextStyle(fontSize: 15),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Color(0xffffffff),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 1,
                              color: Color(0xff737373),
                              offset: Offset(
                                2,
                                2,
                              ),
                            ),
                          ],
                          gradient: null,
                          borderRadius: BorderRadius.all(Radius.circular(
                            7,
                          ))),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: kodereftemancontroller,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.code),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[400]),
                            ),
                            border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey[400]))),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border(
                        bottom: BorderSide(color: Colors.black),
                        top: BorderSide(color: Colors.black),
                        left: BorderSide(color: Colors.black),
                        right: BorderSide(color: Colors.black),
                      )),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () {
                      simpan();
                    },
                    color: Color(0xff0095FF),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      "Registrasi",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Sudah Punya Akun?"),
                      Text(
                        " Login",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
