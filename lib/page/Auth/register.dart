import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login_signup_screen/main.dart';
import 'package:login_signup_screen/page/Auth/loginpage.dart';
import 'package:login_signup_screen/restapi/restapi.dart';
import 'package:lottie/lottie.dart';
import 'package:polygon_clipper/polygon_clipper.dart';
import 'package:http/http.dart' as http;

class Reg extends StatefulWidget {
  const Reg({Key key}) : super(key: key);

  @override
  _RegState createState() => _RegState();
}

class _RegState extends State<Reg> {
  TextEditingController firstname = new TextEditingController();
  TextEditingController lastname = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();
  TextEditingController ulangipasswordcontroller = new TextEditingController();

  bool _checkbox = false;
  bool _checkbox1 = false;
  String jk = "";
  //Other Variables
  bool showPassword = false;
  bool showPassword1 = false;

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
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
            ),
          ],
        );
      },
    );
  }

  simpan() async {
    if (passwordcontroller.text != ulangipasswordcontroller.text) {
      _pesanpassword();
    } else {
      registrasi();
    }
  }

  registrasi() async {
    final response = await http.post(Uri.parse(Restapi.registrasi), body: {
      "name": firstname.text,
      "lastname": lastname.text,
      "email": email.text,
      "password": passwordcontroller.text,
      "gender": jk,
      "hp": phone.text,
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
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 50,
                              ),
                              Text(
                                "LOGIN",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ],
                          )),
                    ),
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
                child: Column(),
                height: double.infinity,
              ),
            ),
          ),
          ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 130, 30, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "SIGN UP",
                      style: TextStyle(fontSize: 25),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "First Name",
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
                            ),
                          ],
                          gradient: null,
                          borderRadius: BorderRadius.all(Radius.circular(
                            7,
                          ))),
                      child: TextFormField(
                        controller: firstname,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
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
                        "Lastname",
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
                        controller: lastname,
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
                    SizedBox(height: 10),
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
                        "Gender",
                        style: TextStyle(fontSize: 15),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: _checkbox,
                              onChanged: (value) {
                                setState(() {
                                  _checkbox = true;
                                  _checkbox1 = false;
                                  jk = "Pria";
                                });
                              },
                            ),
                            Text('Male'),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: _checkbox1,
                              onChanged: (value) {
                                setState(() {
                                  _checkbox1 = true;
                                  _checkbox = false;
                                  jk = "Wanita";
                                });
                              },
                            ),
                            Text('Female'),
                          ],
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Email Address",
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
                        controller: email,
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
                        "Phone",
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
                        controller: phone,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.phone,
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
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
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
                      simpan();
                    },
                    color: Colors.redAccent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      "REGISTRATION",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white,
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
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Loginpage()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("I Have A Account?"),
                    Text(
                      " LOGIN",
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
    path.moveTo(0, size.height * 0.20);

    path.quadraticBezierTo(size.width * 0.30, size.height - 850,
        size.width * 0.75, size.height * 0.2);
    path.quadraticBezierTo(
        size.width * 2, size.height * 0.80, size.width, size.height * 0.30);
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
