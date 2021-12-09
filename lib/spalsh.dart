import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:login_signup_screen/auth/log.dart';
import 'package:login_signup_screen/page/onboarding_page.dart';

class Spash extends StatefulWidget {
  const Spash({Key key}) : super(key: key);

  @override
  _SpashState createState() => _SpashState();
}

class _SpashState extends State<Spash> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  int _current = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    animation = Tween<double>(begin: 0, end: 2).animate(controller)
      ..addListener(() {
        setState(() {
          controller.forward();
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => OnBoardingPage()));
        } else {
          controller.forward();
        }
      });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: HexColor('FFFFFF'),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  SizedBox(child: Image.asset('assets/Logos-01.png')),
                ],
              ),
              Text(
                "SELAMAT DATANG DI EL-SALJAVE GROUPE",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Kali',
                    fontSize: 20,
                    color: HexColor('920003')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
