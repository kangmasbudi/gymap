import 'package:flutter/material.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';

class Detailpromo extends StatefulWidget {
  final String judul;
  final String cover;
  final String deskripsi;

  const Detailpromo({Key key, this.cover, this.deskripsi, this.judul})
      : super(key: key);

  @override
  _DetailpromoState createState() => _DetailpromoState();
}

class _DetailpromoState extends State<Detailpromo> {
  Color mainColor = HexColor('920003');

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
                    'https://elsalvajegroup.com/public/upload/slider/' +
                        widget.cover,
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
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.judul,
                            style: TextStyle(
                                fontFamily: 'Kalilight', fontSize: 15),
                          ),
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
                            style: TextStyle(
                                fontFamily: 'Kalilight', fontSize: 15),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.deskripsi,
                            style: TextStyle(
                              fontFamily: 'Kalilight',
                            ),
                          )
                        ],
                      ),
                      height: MediaQuery.of(context).size.width * .9,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
