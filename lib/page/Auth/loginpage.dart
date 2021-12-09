import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login_signup_screen/auth/register.dart';
import 'package:login_signup_screen/page/Auth/register.dart';
import 'package:login_signup_screen/page/onboarding_page.dart';
import 'package:login_signup_screen/restapi/restapi.dart';
import 'package:login_signup_screen/widget/button_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:polygon_clipper/polygon_clipper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Loginpage extends StatefulWidget {
  const Loginpage({Key key}) : super(key: key);

  @override
  _LoginpageState createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  TextEditingController passwordcontroller = new TextEditingController();
  TextEditingController emailcontroller = new TextEditingController();

  //menyimpan data session
  savePref(
    int value,
    String id,
    name,
    lastname,
    email,
    hp,
    status,
  ) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt('value', value);
      preferences.setString('id', id);
      preferences.setString('name', name);
      preferences.setString('lastname', lastname);
      preferences.setString('email', email);
      preferences.setString('hp', hp);
      preferences.setString('status', status);
      preferences.commit();
    });
  }

  Future<void> _pesangagallogin() async {
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
                  'Email Dan Passwod Tidak Sama',
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

  //cek login ke database

  simpan() async {
    final response = await http.post(Uri.parse(Restapi.login), body: {
      "email": emailcontroller.text,
      "password": passwordcontroller.text,
    });

    final data = jsonDecode(response.body);
    int value = data['value'];
    String name = data['name'];
    String lastname = data['lastname'];
    int id = data['id'];
    String hp = data['hp'];
    String status = data['status'];
    String email = data['email'];

    if (value == 1) {
      setState(() {
        savePref(value, id.toString(), name, email, hp, status, lastname);
      });
      print("Anda Berhasil Login");
    } else {
      _pesangagallogin();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            left: 240,
            bottom: 650,
            child: Container(
              height: 250,
              child: ClipPolygon(
                sides: 4,
                borderRadius: 10.0, // Default 0.0 degrees
                rotate: 0, // Default 0.0 degrees
                child: Container(
                  child: Center(
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 50,
                            ),
                            Text(
                              "SIGNUP",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ],
                        )),
                  ),
                  decoration: BoxDecoration(color: Colors.redAccent),
                ),
              ),
            ),
          ),
          LinearGradientMask(
            child: CustomPaint(
              painter: CurvePainter(),
              child: Container(
                height: double.infinity,
              ),
            ),
          ),
          ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 330, 30, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Login",
                      style: TextStyle(fontSize: 25),
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
                                1,
                                1,
                              ),
                            ),
                          ],
                          gradient: null,
                          borderRadius: BorderRadius.all(Radius.circular(
                            7,
                          ))),
                      child: TextFormField(
                        controller: emailcontroller,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.email,
                            ),
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
                    Container(
                      decoration: BoxDecoration(
                          color: Color(0xffffffff),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 1,
                              color: Color(0xff737373),
                              offset: Offset(
                                1,
                                1,
                              ),
                            ),
                          ],
                          gradient: null,
                          borderRadius: BorderRadius.all(Radius.circular(
                            7,
                          ))),
                      child: TextFormField(
                        controller: passwordcontroller,
                        decoration: InputDecoration(
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
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  print("masuk");
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
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
                        print("masuk");

                        simpan();
                      },
                      color: Colors.redAccent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        "Masuk",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Reg()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Tidak Punya Akun?"),
                    Text(
                      " Daftar",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void goToOnBoarding(context) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => OnBoardingPage()),
      );
}

class DrawPoligon extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.8);
    path.lineTo(size.width * 0.8, size.height);
    path.lineTo(size.width * 0.2, size.height);
    path.lineTo(0, size.height * 0.8);
    path.lineTo(0, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()..color = Colors.amber;
    // create a path
    var path = Path();
    path.moveTo(0, size.height * 0.25);

    path.quadraticBezierTo(size.width * 0.20, size.height * 0.13,
        size.width * 0.45, size.height * 0.25);
    path.quadraticBezierTo(
        size.width * 0.75, size.height * 0.39, size.width, size.height * 0.53);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class LinearGradientMask extends StatelessWidget {
  LinearGradientMask({this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) {
        return LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: <Color>[
            Colors.black12,
            Colors.black12,
          ],
          tileMode: TileMode.mirror,
        ).createShader(bounds);
      },
      child: child,
    );
  }
}
