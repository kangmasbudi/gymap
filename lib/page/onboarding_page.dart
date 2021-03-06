import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:login_signup_screen/page/home_page.dart';
import 'package:login_signup_screen/widget/button_widget.dart';

class OnBoardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SafeArea(
        child: IntroductionScreen(
          pages: [
            PageViewModel(
              title: 'GAIN',
              body: 'The man who never reads lives only one.',
              image: buildImage('assets/G.png'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'YOGA',
              body: 'Available right at your fingerprints',
              image: buildImage('assets/Y.png'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'MEAL',
              body: 'For enhanced reading experience',
              image: buildImage('assets/M.png'),
              decoration: getPageDecoration(),
            ),
          ],
          done: Text('Login',
              style: TextStyle(
                  fontFamily: 'Kalilight', fontWeight: FontWeight.w600)),
          onDone: () => goToHome(context),
          showSkipButton: true,
          skip: Text('Skip',
              style: TextStyle(
                  fontFamily: 'Kalilight', fontWeight: FontWeight.w600)),
          onSkip: () => goToHome(context),
          next: Icon(Icons.arrow_forward),
          dotsDecorator: getDotDecoration(),
          onChange: (index) => print('Page $index selected'),
          globalBackgroundColor: Theme.of(context).primaryColor,
          skipFlex: 0,
          nextFlex: 0,
          // isProgressTap: false,
          // isProgress: false,
          // showNextButton: false,
          // freeze: true,
          // animationDuration: 1000,
        ),
      );

  void goToHome(context) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => HomePage()),
      );

  Widget buildImage(String path) => Center(
          child: Image.asset(
        path,
        width: 250,
        fit: BoxFit.contain,
      ));

  DotsDecorator getDotDecoration() => DotsDecorator(
        color: Color(0xFFBDBDBD),
        //activeColor: Colors.orange,
        size: Size(10, 10),
        activeSize: Size(22, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      );

  PageDecoration getPageDecoration() => PageDecoration(
        titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        bodyTextStyle: TextStyle(fontSize: 20),
        descriptionPadding: EdgeInsets.all(1).copyWith(bottom: 0),
        imagePadding: EdgeInsets.all(1),
        pageColor: Colors.white,
      );
}
