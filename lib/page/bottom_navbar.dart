import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_signup_screen/page/Dashboard.dart';
import 'package:login_signup_screen/page/allkeranjangku.dart';
import 'package:login_signup_screen/restapi/restapi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'navpage1.dart';
import 'navpage2.dart';
import 'navpage3.dart';
import 'navpage4.dart';

class BottomNavigation2Page extends StatefulWidget {
  @override
  _BottomNavigation2PageState createState() => _BottomNavigation2PageState();
}

class _BottomNavigation2PageState extends State<BottomNavigation2Page> {
  // initialize global widget

  Color _color1 = HexColor('#DFFF00');
  Color _color2 = Color(0xFFFFFFF1);
  Color _color3 = Color(0xFFe75f3f);

  PageController _pageController;
  int _currentIndex = 0;

  // Pages if you click bottom navigation
  final List<Widget> _contentPages = <Widget>[
    Dashboard(),
    Allkeranjangku(),
    Navpage3(),
    Navpage4(),
  ];

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

  @override
  void initState() {
    // set initial pages for navigation to home page
    _pageController = PageController(initialPage: 0);
    _pageController.addListener(_handleTabSelection);

    super.initState();
    ambilnomeradmin();
  }

  Color mainColor = HexColor('920003');

  keluar() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.remove('id');
      preferences.remove('name');
      preferences.remove('email');
      preferences.remove('hp');
      preferences.remove('status');
      preferences.commit();
    });
    exit(0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    setState(() {});
  }

  DateTime timebackpress = DateTime.now();
  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          final different = DateTime.now().difference(timebackpress);
          final isExitWarning = different >= Duration(seconds: 1);
          timebackpress = DateTime.now();
          if (isExitWarning) {
            final message = 'Press again to exit';
            Fluttertoast.showToast(msg: message, fontSize: 18);
            return false;
          } else {
            Fluttertoast.cancel();
            return true;
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: PageView(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            children: _contentPages.map((Widget content) {
              return content;
            }).toList(),
          ),
          bottomNavigationBar: BottomAppBar(
            color: mainColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      _tapNav(0);
                    },
                    child: Container(
                        padding: EdgeInsets.all(16),
                        child: Icon(Icons.home,
                            color: _currentIndex == 0 ? _color1 : _color2))),
                GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      _tapNav(1);
                    },
                    child: Container(
                        padding: EdgeInsets.all(16),
                        margin: EdgeInsets.only(right: 32),
                        child: Icon(Icons.shopping_cart,
                            color: _currentIndex == 1 ? _color3 : _color2))),
                GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      _tapNav(2);
                    },
                    child: Container(
                        padding: EdgeInsets.all(16),
                        margin: EdgeInsets.only(left: 32),
                        child: Icon(Icons.list_alt_rounded,
                            color: _currentIndex == 2 ? _color1 : _color2))),
                GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      _tapNav(3);
                    },
                    child: Container(
                        padding: EdgeInsets.all(16),
                        child: Icon(Icons.person,
                            color: _currentIndex == 3 ? _color1 : _color2))),
              ],
            ),
            shape: CircularNotchedRectangle(),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              setuju();

              //Fluttertoast.showToast(msg: 'FAB Pressed', toastLength: Toast.LENGTH_SHORT);
            },
            backgroundColor: HexColor('FFD700'),
            child: Icon(
              Icons.exit_to_app,
              color: Colors.black,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        ),
      );

  void _tapNav(index) {
    _currentIndex = index;
    _pageController.jumpToPage(index);

    // this unfocus is to prevent show keyboard in the text field
    FocusScope.of(context).unfocus();
  }
}
