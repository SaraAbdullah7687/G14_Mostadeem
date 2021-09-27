import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'calendar.dart';

class home3 extends StatelessWidget {
  home3({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff053f5e),
      body: Stack(
        children: <Widget>[
          Pinned.fromPins(
            Pin(start: -7.4, end: -7.4),
            Pin(start: 0.0, end: 0.0),
            child:
                // Adobe XD layer: 'bg' (shape)
                SvgPicture.string(
              _svg_n3a8e2,
              allowDrawingOutsideViewBox: true,
              fit: BoxFit.fill,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 90.0, start: 25.0),
            Pin(size: 110.0, middle: 0.5328),
            child:
                // Adobe XD layer: 'bone' (group)
                Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(start: 0.0, end: 0.0),
                  Pin(start: 0.0, end: 0.0),
                  child:
                      // Adobe XD layer: 'bg' (shape)
                      SvgPicture.string(
                    _svg_b6gdlh,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
                Pinned.fromPins(
                  Pin(start: 15.0, end: 15.0),
                  Pin(size: 20.0, end: 15.0),
                  child:
                      // Adobe XD layer: 'button bg' (shape)
                      Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: const Color(0x12d9fffa),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 30.0, middle: 0.4833),
                  Pin(size: 18.0, middle: 0.5652),
                  child: Text(
                    'Cans',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 13,
                      color: const Color(0xffffffff),
                      letterSpacing: 0.195,
                      fontWeight: FontWeight.w500,
                      height: 2.076923076923077,
                    ),
                    textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Pinned.fromPins(
            Pin(size: 90.0, end: 40.0),
            Pin(size: 110.0, middle: 0.3362),
            child:
                // Adobe XD layer: 'brain' (group)
                Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(start: 0.0, end: 0.0),
                  Pin(start: 0.0, end: 0.0),
                  child:
                      // Adobe XD layer: 'bg' (shape)
                      Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: const Color(0xff107163),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x17000000),
                          offset: Offset(0, 15),
                          blurRadius: 15,
                        ),
                      ],
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(start: 15.0, end: 15.0),
                  Pin(size: 20.0, end: 15.0),
                  child:
                      // Adobe XD layer: 'button bg' (shape)
                      Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: const Color(0x12d9fffa),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 40.0, middle: 0.5),
                  Pin(size: 18.0, middle: 0.5652),
                  child: Text(
                    'Plastic',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 13,
                      color: const Color(0xffffffff),
                      letterSpacing: 0.195,
                      fontWeight: FontWeight.w500,
                      height: 2.076923076923077,
                    ),
                    textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Pinned.fromPins(
            Pin(size: 90.0, middle: 0.4737),
            Pin(size: 110.0, middle: 0.3362),
            child:
                // Adobe XD layer: 'heart' (group)
                Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(start: 0.0, end: 0.0),
                  Pin(start: 0.0, end: 0.0),
                  child:
                      // Adobe XD layer: 'bg' (shape)
                      Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: const Color(0xff107163),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x17000000),
                          offset: Offset(0, 15),
                          blurRadius: 15,
                        ),
                      ],
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(start: 15.0, end: 15.0),
                  Pin(size: 20.0, end: 15.0),
                  child:
                      // Adobe XD layer: 'button bg' (shape)
                      Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: const Color(0x12d9fffa),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 33.0, middle: 0.5088),
                  Pin(size: 18.0, middle: 0.5652),
                  child: Text(
                    'Glass',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 13,
                      color: const Color(0xffffffff),
                      letterSpacing: 0.195,
                      fontWeight: FontWeight.w500,
                      height: 2.076923076923077,
                    ),
                    textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
          Pinned.fromPins(
            Pin(size: 90.0, start: 25.0),
            Pin(size: 110.0, middle: 0.3362),
            child:
                // Adobe XD layer: 'dental' (group)
                Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(start: 0.0, end: 0.0),
                  Pin(start: 0.0, end: 0.0),
                  child:
                      // Adobe XD layer: 'bg' (shape)
                      Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: const Color(0xff107163),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x17000000),
                          offset: Offset(0, 15),
                          blurRadius: 15,
                        ),
                      ],
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(start: 15.0, end: 15.0),
                  Pin(size: 20.0, end: 15.0),
                  child:
                      // Adobe XD layer: 'button bg' (shape)
                      Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: const Color(0x12d9fffa),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 35.0, middle: 0.4727),
                  Pin(size: 18.0, middle: 0.5652),
                  child: Text(
                    'Paper',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 13,
                      color: const Color(0xffffffff),
                      letterSpacing: 0.195,
                      fontWeight: FontWeight.w500,
                      height: 2.076923076923077,
                    ),
                    textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
          Pinned.fromPins(
            Pin(size: 84.0, start: 25.0),
            Pin(size: 26.0, middle: 0.2417),
            child: Text(
              'Category',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 20,
                color: const Color(0xff363636),
                letterSpacing: 0.3,
                fontWeight: FontWeight.w700,
                height: 1.35,
              ),
              textHeightBehavior:
                  TextHeightBehavior(applyHeightToFirstAscent: false),
              textAlign: TextAlign.left,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 267.0, start: 47.0),
            Pin(size: 26.0, start: 95.0),
            child: Text(
              'What do you want to recycle?',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 20,
                color: const Color(0xff363636),
                letterSpacing: 0.3,
                height: 2,
              ),
              textHeightBehavior:
                  TextHeightBehavior(applyHeightToFirstAscent: false),
              textAlign: TextAlign.left,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 200.0, end: 40.0),
            Pin(size: 110.0, middle: 0.5328),
            child:
                // Adobe XD layer: 'bone' (group)
                Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(size: 90.0, start: 0.0),
                  Pin(start: 0.0, end: 0.0),
                  child:
                      // Adobe XD layer: 'bg' (shape)
                      SvgPicture.string(
                    _svg_b6gdlh,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 60.0, start: 15.0),
                  Pin(size: 20.0, end: 15.0),
                  child:
                      // Adobe XD layer: 'button bg' (shape)
                      Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: const Color(0x12d9fffa),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 66.0, start: 11.0),
                  Pin(size: 18.0, middle: 0.5652),
                  child: Text(
                    'Electronics',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 13,
                      color: const Color(0xffffffff),
                      letterSpacing: 0.195,
                      fontWeight: FontWeight.w500,
                      height: 2.076923076923077,
                    ),
                    textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),
                    textAlign: TextAlign.center,
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 90.0, end: 0.0),
                  Pin(start: 0.0, end: 0.0),
                  child:
                      // Adobe XD layer: 'bone' (group)
                      Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(start: 0.0, end: 0.0),
                        Pin(start: 0.0, end: 0.0),
                        child:
                            // Adobe XD layer: 'bg' (shape)
                            SvgPicture.string(
                          _svg_b6gdlh,
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(start: 15.0, end: 15.0),
                        Pin(size: 20.0, end: 15.0),
                        child:
                            // Adobe XD layer: 'button bg' (shape)
                            Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: const Color(0x12d9fffa),
                          ),
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(size: 46.0, middle: 0.4773),
                        Pin(size: 18.0, middle: 0.5652),
                        child: Text(
                          'Clothes',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 13,
                            color: const Color(0xffffffff),
                            letterSpacing: 0.195,
                            fontWeight: FontWeight.w500,
                            height: 2.076923076923077,
                          ),
                          textHeightBehavior: TextHeightBehavior(
                              applyHeightToFirstAscent: false),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Pinned.fromPins(
            Pin(start: 25.0, end: 40.0),
            Pin(size: 110.0, middle: 0.7293),
            child:
                // Adobe XD layer: 'bone' (group)
                Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(size: 90.0, start: 0.0),
                  Pin(start: 0.0, end: 0.0),
                  child:
                      // Adobe XD layer: 'bg' (shape)
                      SvgPicture.string(
                    _svg_b6gdlh,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 60.0, start: 15.0),
                  Pin(size: 20.0, end: 15.0),
                  child:
                      // Adobe XD layer: 'button bg' (shape)
                      Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: const Color(0x12d9fffa),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 34.0, start: 27.0),
                  Pin(size: 18.0, middle: 0.5652),
                  child: Text(
                    'Nylon',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 13,
                      color: const Color(0xffffffff),
                      letterSpacing: 0.195,
                      fontWeight: FontWeight.w500,
                      height: 2.076923076923077,
                    ),
                    textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),
                    textAlign: TextAlign.center,
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 200.0, end: 0.0),
                  Pin(start: 0.0, end: 0.0),
                  child:
                      // Adobe XD layer: 'bone' (group)
                      Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(size: 90.0, start: 0.0),
                        Pin(start: 0.0, end: 0.0),
                        child:
                            // Adobe XD layer: 'bg' (shape)
                            SvgPicture.string(
                          _svg_b6gdlh,
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(size: 60.0, start: 15.0),
                        Pin(size: 20.0, end: 15.0),
                        child:
                            // Adobe XD layer: 'button bg' (shape)
                            Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: const Color(0x12d9fffa),
                          ),
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(size: 40.0, start: 24.0),
                        Pin(size: 18.0, middle: 0.5652),
                        child: Text(
                          'Metals',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 13,
                            color: const Color(0xffffffff),
                            letterSpacing: 0.195,
                            fontWeight: FontWeight.w500,
                            height: 2.076923076923077,
                          ),
                          textHeightBehavior: TextHeightBehavior(
                              applyHeightToFirstAscent: false),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(size: 90.0, end: 0.0),
                        Pin(start: 0.0, end: 0.0),
                        child:
                            // Adobe XD layer: 'bone' (group)
                            Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(start: 0.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child:
                                  // Adobe XD layer: 'bg' (shape)
                                  SvgPicture.string(
                                _svg_b6gdlh,
                                allowDrawingOutsideViewBox: true,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(start: 15.0, end: 15.0),
                              Pin(size: 20.0, end: 15.0),
                              child:
                                  // Adobe XD layer: 'button bg' (shape)
                                  Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: const Color(0x12d9fffa),
                                ),
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(size: 54.0, middle: 0.4722),
                              Pin(size: 18.0, middle: 0.5652),
                              child: Text(
                                'Batteries',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 13,
                                  color: const Color(0xffffffff),
                                  letterSpacing: 0.195,
                                  fontWeight: FontWeight.w500,
                                  height: 2.076923076923077,
                                ),
                                textHeightBehavior: TextHeightBehavior(
                                    applyHeightToFirstAscent: false),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Pinned.fromPins(
          //   Pin(start: 25.0, end: 25.0),
          //   Pin(size: 54.0, end: 47.0),

          //   ),
        ],
      ),
      //==========================================
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const calendar()),
          );
        },

        child:
            // Adobe XD layer: 'button' (group)
            Stack(
          children: <Widget>[
            Pinned.fromPins(
              Pin(start: 0.0, end: 0.0),
              Pin(start: 0.0, end: 0.0),
              child:
                  // Adobe XD layer: 'button bg' (shape)
                  Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: const Color(0xff107163),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x17000000),
                      offset: Offset(0, 15),
                      blurRadius: 15,
                    ),
                  ],
                ),
              ),
            ),
            //###########################3333
            Pinned.fromPins(
              Pin(size: 42.0, middle: 0.4735),
              Pin(size: 26.0, middle: 0.5),
              child: Text(
                'Next ',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 20,
                  color: const Color(0xffffffff),
                  letterSpacing: 0.3,
                  fontWeight: FontWeight.w500,
                  height: 1.35,
                ),
                textHeightBehavior:
                    TextHeightBehavior(applyHeightToFirstAscent: false),
                textAlign: TextAlign.center,
              ),
            ),
            //###########################3333
          ],
        ),
        //========================

        //===========================
      ),
      //==============================================
    );
  }
}

const String _svg_b6gdlh =
    '<svg viewBox="355.0 326.0 90.0 110.0" ><defs><filter id="shadow"><feDropShadow dx="0" dy="15" stdDeviation="15"/></filter></defs><path transform="translate(355.0, 326.0)" d="M 5 0 L 85 0 C 87.76142120361328 0 90 2.238576173782349 90 5 L 90 105 C 90 107.7614212036133 87.76142120361328 110 85 110 L 5 110 C 2.238576173782349 110 0 107.7614212036133 0 105 L 0 5 C 0 2.238576173782349 2.238576173782349 0 5 0 Z" fill="#107163" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></svg>';
const String _svg_n3a8e2 =
    '<svg viewBox="-7.4 0.0 389.7 812.0" ><path transform="matrix(-1.0, 0.0, 0.0, -1.0, 375.0, 812.0)" d="M 0 0 L 375 0 L 375 779.0811157226562 C 375 797.26171875 391.5685424804688 812 375 812 L 0 812 C -16.56854248046875 812 0 797.26171875 0 779.0811157226562 L 0 0 Z" fill="#f6f6f6" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';

class calendar extends StatelessWidget {
  const calendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f6f6),
      body: Stack(
        children: <Widget>[
          Pinned.fromPins(
            Pin(start: 25.0, end: 25.0),
            Pin(size: 54.0, end: 25.0),
            child:
                // Adobe XD layer: 'button' (group)
                Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(start: 0.0, end: 0.0),
                  Pin(start: 0.0, end: 0.0),
                  child:
                      // Adobe XD layer: 'button bg' (shape)
                      Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: const Color(0xff107163),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x17000000),
                          offset: Offset(0, 15),
                          blurRadius: 15,
                        ),
                      ],
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 43.0, middle: 0.4681),
                  Pin(size: 26.0, middle: 0.5),
                  child: Text(
                    'Next',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 20,
                      color: const Color(0xffffffff),
                      letterSpacing: 0.3,
                      fontWeight: FontWeight.w500,
                      height: 1.35,
                    ),
                    textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
          Pinned.fromPins(
            Pin(start: 25.0, end: 25.0),
            Pin(size: 83.0, end: 100.0),
            child:
                // Adobe XD layer: 'evening' (group)
                Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(size: 95.0, end: 0.0),
                  Pin(size: 34.0, end: 0.0),
                  child:
                      // Adobe XD layer: '6' (group)
                      Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(start: 0.0, end: 0.0),
                        Pin(start: 0.0, end: 0.0),
                        child:
                            // Adobe XD layer: 'bg' (shape)
                            Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: const Color(0xffffffff),
                          ),
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(start: 10.0, end: 10.0),
                        Pin(size: 16.0, middle: 0.5),
                        child: Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(size: 14.0, start: 0.0),
                              Pin(start: 2.0, end: 0.0),
                              child: Stack(
                                children: <Widget>[
                                  Container(),
                                  Pinned.fromPins(
                                    Pin(size: 4.0, middle: 0.6969),
                                    Pin(size: 4.2, middle: 0.3401),
                                    child: SvgPicture.string(
                                      _svg_t5al53,
                                      allowDrawingOutsideViewBox: true,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(size: 52.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child: Text(
                                '08:00 PM',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 12,
                                  color: const Color(0xff363636),
                                  letterSpacing: 0.18,
                                  height: 2.25,
                                ),
                                textHeightBehavior: TextHeightBehavior(
                                    applyHeightToFirstAscent: false),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 95.0, middle: 0.5),
                  Pin(size: 34.0, end: 0.0),
                  child:
                      // Adobe XD layer: '5' (group)
                      Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(start: 0.0, end: 0.0),
                        Pin(start: 0.0, end: 0.0),
                        child:
                            // Adobe XD layer: 'bg' (shape)
                            Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: const Color(0xffffffff),
                          ),
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(start: 10.0, end: 10.0),
                        Pin(size: 16.0, middle: 0.5),
                        child: Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(size: 14.0, start: 0.0),
                              Pin(start: 2.0, end: 0.0),
                              child: Stack(
                                children: <Widget>[
                                  Container(),
                                  Pinned.fromPins(
                                    Pin(size: 4.0, middle: 0.6969),
                                    Pin(size: 4.2, middle: 0.3401),
                                    child: SvgPicture.string(
                                      _svg_t5al53,
                                      allowDrawingOutsideViewBox: true,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(size: 52.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child: Text(
                                '07:30 PM',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 12,
                                  color: const Color(0xff363636),
                                  letterSpacing: 0.18,
                                  height: 2.25,
                                ),
                                textHeightBehavior: TextHeightBehavior(
                                    applyHeightToFirstAscent: false),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 95.0, start: 0.0),
                  Pin(size: 34.0, end: 0.0),
                  child:
                      // Adobe XD layer: '4' (group)
                      Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(start: 0.0, end: 0.0),
                        Pin(start: 0.0, end: 0.0),
                        child:
                            // Adobe XD layer: 'bg' (shape)
                            Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: const Color(0xffffffff),
                          ),
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(start: 10.0, end: 10.0),
                        Pin(size: 16.0, middle: 0.5),
                        child: Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(size: 14.0, start: 0.0),
                              Pin(start: 2.0, end: 0.0),
                              child: Stack(
                                children: <Widget>[
                                  Container(),
                                  Pinned.fromPins(
                                    Pin(size: 4.0, middle: 0.6969),
                                    Pin(size: 4.2, middle: 0.3401),
                                    child: SvgPicture.string(
                                      _svg_t5al53,
                                      allowDrawingOutsideViewBox: true,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(size: 52.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child: Text(
                                '07:00 PM',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 12,
                                  color: const Color(0xff363636),
                                  letterSpacing: 0.18,
                                  height: 2.25,
                                ),
                                textHeightBehavior: TextHeightBehavior(
                                    applyHeightToFirstAscent: false),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 95.0, end: 0.0),
                  Pin(size: 34.0, start: 0.0),
                  child:
                      // Adobe XD layer: '3' (group)
                      Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(start: 0.0, end: 0.0),
                        Pin(start: 0.0, end: 0.0),
                        child:
                            // Adobe XD layer: 'bg' (shape)
                            Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: const Color(0xffffffff),
                          ),
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(start: 10.0, end: 10.0),
                        Pin(size: 16.0, middle: 0.4444),
                        child: Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(size: 14.0, start: 0.0),
                              Pin(start: 2.0, end: 0.0),
                              child: Stack(
                                children: <Widget>[
                                  Container(),
                                  Pinned.fromPins(
                                    Pin(size: 4.0, middle: 0.6969),
                                    Pin(size: 4.2, middle: 0.3401),
                                    child: SvgPicture.string(
                                      _svg_t5al53,
                                      allowDrawingOutsideViewBox: true,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(size: 52.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child: Text(
                                '06:30 PM',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 12,
                                  color: const Color(0xff363636),
                                  letterSpacing: 0.18,
                                  height: 2.25,
                                ),
                                textHeightBehavior: TextHeightBehavior(
                                    applyHeightToFirstAscent: false),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 95.0, middle: 0.5),
                  Pin(size: 34.0, start: 0.0),
                  child:
                      // Adobe XD layer: '2' (group)
                      Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(start: 0.0, end: 0.0),
                        Pin(start: 0.0, end: 0.0),
                        child:
                            // Adobe XD layer: 'bg' (shape)
                            Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: const Color(0xffffffff),
                          ),
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(start: 10.0, end: 10.0),
                        Pin(size: 16.0, middle: 0.4444),
                        child: Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(size: 14.0, start: 0.0),
                              Pin(start: 2.0, end: 0.0),
                              child: Stack(
                                children: <Widget>[
                                  Container(),
                                  Pinned.fromPins(
                                    Pin(size: 4.0, middle: 0.6969),
                                    Pin(size: 4.2, middle: 0.3401),
                                    child: SvgPicture.string(
                                      _svg_t5al53,
                                      allowDrawingOutsideViewBox: true,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(size: 52.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child: Text(
                                '06:00 PM',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 12,
                                  color: const Color(0xff363636),
                                  letterSpacing: 0.18,
                                  height: 2.25,
                                ),
                                textHeightBehavior: TextHeightBehavior(
                                    applyHeightToFirstAscent: false),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 95.0, start: 0.0),
                  Pin(size: 34.0, start: 0.0),
                  child:
                      // Adobe XD layer: '1' (group)
                      Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(start: 0.0, end: 0.0),
                        Pin(start: 0.0, end: 0.0),
                        child:
                            // Adobe XD layer: 'bg' (shape)
                            Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: const Color(0xffffffff),
                          ),
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(start: 10.0, end: 10.0),
                        Pin(size: 16.0, middle: 0.4444),
                        child: Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(size: 14.0, start: 0.0),
                              Pin(start: 2.0, end: 0.0),
                              child: Stack(
                                children: <Widget>[
                                  Container(),
                                  Pinned.fromPins(
                                    Pin(size: 4.0, middle: 0.6969),
                                    Pin(size: 4.2, middle: 0.3401),
                                    child: SvgPicture.string(
                                      _svg_t5al53,
                                      allowDrawingOutsideViewBox: true,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(size: 52.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child: Text(
                                '05:30 PM',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 12,
                                  color: const Color(0xff363636),
                                  letterSpacing: 0.18,
                                  height: 2.25,
                                ),
                                textHeightBehavior: TextHeightBehavior(
                                    applyHeightToFirstAscent: false),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Pinned.fromPins(
            Pin(start: 25.0, end: 25.0),
            Pin(size: 83.0, middle: 0.7202),
            child:
                // Adobe XD layer: 'morning' (group)
                Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(size: 95.0, end: 0.0),
                  Pin(size: 34.0, end: 0.0),
                  child:
                      // Adobe XD layer: '6' (group)
                      Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(start: 0.0, end: 0.0),
                        Pin(start: 0.0, end: 0.0),
                        child:
                            // Adobe XD layer: 'bg' (shape)
                            Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: const Color(0xffffffff),
                          ),
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(start: 10.0, end: 10.0),
                        Pin(size: 16.0, middle: 0.5),
                        child: Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(size: 14.0, start: 0.0),
                              Pin(start: 2.0, end: 0.0),
                              child: Stack(
                                children: <Widget>[
                                  Container(),
                                  Pinned.fromPins(
                                    Pin(size: 4.0, middle: 0.6969),
                                    Pin(size: 4.2, middle: 0.3401),
                                    child: SvgPicture.string(
                                      _svg_t5al53,
                                      allowDrawingOutsideViewBox: true,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(size: 52.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child: Text(
                                '11:00 AM',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 12,
                                  color: const Color(0xff363636),
                                  letterSpacing: 0.18,
                                  height: 2.25,
                                ),
                                textHeightBehavior: TextHeightBehavior(
                                    applyHeightToFirstAscent: false),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 95.0, middle: 0.5),
                  Pin(size: 34.0, end: 0.0),
                  child:
                      // Adobe XD layer: '5' (group)
                      Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(start: 0.0, end: 0.0),
                        Pin(start: 0.0, end: 0.0),
                        child:
                            // Adobe XD layer: 'bg' (shape)
                            Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: const Color(0xffffffff),
                          ),
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(start: 10.0, end: 10.0),
                        Pin(size: 16.0, middle: 0.5),
                        child: Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(size: 14.0, start: 0.0),
                              Pin(start: 2.0, end: 0.0),
                              child: Stack(
                                children: <Widget>[
                                  Container(),
                                  Pinned.fromPins(
                                    Pin(size: 4.0, middle: 0.6969),
                                    Pin(size: 4.2, middle: 0.3401),
                                    child: SvgPicture.string(
                                      _svg_t5al53,
                                      allowDrawingOutsideViewBox: true,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(size: 52.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child: Text(
                                '10:30 AM',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 12,
                                  color: const Color(0xff363636),
                                  letterSpacing: 0.18,
                                  height: 2.25,
                                ),
                                textHeightBehavior: TextHeightBehavior(
                                    applyHeightToFirstAscent: false),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 95.0, start: 0.0),
                  Pin(size: 34.0, end: 0.0),
                  child:
                      // Adobe XD layer: '4' (group)
                      Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(start: 0.0, end: 0.0),
                        Pin(start: 0.0, end: 0.0),
                        child:
                            // Adobe XD layer: 'bg' (shape)
                            Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: const Color(0xffffffff),
                          ),
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(start: 10.0, end: 10.0),
                        Pin(size: 16.0, middle: 0.5),
                        child: Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(size: 14.0, start: 0.0),
                              Pin(start: 2.0, end: 0.0),
                              child: Stack(
                                children: <Widget>[
                                  Container(),
                                  Pinned.fromPins(
                                    Pin(size: 4.0, middle: 0.6969),
                                    Pin(size: 4.2, middle: 0.3401),
                                    child: SvgPicture.string(
                                      _svg_t5al53,
                                      allowDrawingOutsideViewBox: true,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(size: 52.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child: Text(
                                '10:00 AM',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 12,
                                  color: const Color(0xff363636),
                                  letterSpacing: 0.18,
                                  height: 2.25,
                                ),
                                textHeightBehavior: TextHeightBehavior(
                                    applyHeightToFirstAscent: false),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 95.0, end: 0.0),
                  Pin(size: 34.0, start: 0.0),
                  child:
                      // Adobe XD layer: '3' (group)
                      Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(start: 0.0, end: 0.0),
                        Pin(start: 0.0, end: 0.0),
                        child:
                            // Adobe XD layer: 'bg' (shape)
                            Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: const Color(0xffffffff),
                          ),
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(start: 10.0, end: 10.0),
                        Pin(size: 16.0, middle: 0.4444),
                        child: Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(size: 14.0, start: 0.0),
                              Pin(start: 2.0, end: 0.0),
                              child: Stack(
                                children: <Widget>[
                                  Container(),
                                  Pinned.fromPins(
                                    Pin(size: 4.0, middle: 0.6969),
                                    Pin(size: 4.2, middle: 0.3401),
                                    child: SvgPicture.string(
                                      _svg_t5al53,
                                      allowDrawingOutsideViewBox: true,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(size: 52.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child: Text(
                                '09:30 AM',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 12,
                                  color: const Color(0xff363636),
                                  letterSpacing: 0.18,
                                  height: 2.25,
                                ),
                                textHeightBehavior: TextHeightBehavior(
                                    applyHeightToFirstAscent: false),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 95.0, middle: 0.5),
                  Pin(size: 34.0, start: 0.0),
                  child:
                      // Adobe XD layer: '2' (group)
                      Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(start: 0.0, end: 0.0),
                        Pin(start: 0.0, end: 0.0),
                        child:
                            // Adobe XD layer: 'bg' (shape)
                            Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: const Color(0xff107163),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0x17000000),
                                offset: Offset(0, 10),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(start: 10.0, end: 10.0),
                        Pin(size: 16.0, middle: 0.4444),
                        child: Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(size: 14.0, start: 0.0),
                              Pin(start: 2.0, end: 0.0),
                              child: Stack(
                                children: <Widget>[
                                  Container(),
                                  Pinned.fromPins(
                                    Pin(size: 4.0, middle: 0.6969),
                                    Pin(size: 4.2, middle: 0.3401),
                                    child: SvgPicture.string(
                                      _svg_aytwr,
                                      allowDrawingOutsideViewBox: true,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(size: 52.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child: Text(
                                '09:00 AM',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 12,
                                  color: const Color(0xffffffff),
                                  letterSpacing: 0.18,
                                  height: 2.25,
                                ),
                                textHeightBehavior: TextHeightBehavior(
                                    applyHeightToFirstAscent: false),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 95.0, start: 0.0),
                  Pin(size: 34.0, start: 0.0),
                  child:
                      // Adobe XD layer: '1' (group)
                      Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(start: 0.0, end: 0.0),
                        Pin(start: 0.0, end: 0.0),
                        child:
                            // Adobe XD layer: 'bg' (shape)
                            Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: const Color(0xffffffff),
                          ),
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(start: 10.0, end: 10.0),
                        Pin(size: 16.0, middle: 0.4444),
                        child: Stack(
                          children: <Widget>[
                            Pinned.fromPins(
                              Pin(size: 14.0, start: 0.0),
                              Pin(start: 2.0, end: 0.0),
                              child: Stack(
                                children: <Widget>[
                                  Container(),
                                  Pinned.fromPins(
                                    Pin(size: 4.0, middle: 0.6969),
                                    Pin(size: 4.2, middle: 0.3401),
                                    child: SvgPicture.string(
                                      _svg_t5al53,
                                      allowDrawingOutsideViewBox: true,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Pinned.fromPins(
                              Pin(size: 52.0, end: 0.0),
                              Pin(start: 0.0, end: 0.0),
                              child: Text(
                                '08:30 AM',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 12,
                                  color: const Color(0xff363636),
                                  letterSpacing: 0.18,
                                  height: 2.25,
                                ),
                                textHeightBehavior: TextHeightBehavior(
                                    applyHeightToFirstAscent: false),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Pinned.fromPins(
            Pin(size: 16.6, start: 26.5),
            Pin(size: 11.9, start: 34.0),
            child:
                // Adobe XD layer: 'back icon' (group)
                Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(start: 0.0, end: 0.0),
                  Pin(size: 1.0, middle: 0.546),
                  child: SvgPicture.string(
                    _svg_l46t,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 5.9, start: 0.0),
                  Pin(size: 5.9, start: 0.0),
                  child: SvgPicture.string(
                    _svg_komme,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 5.9, start: 0.0),
                  Pin(size: 5.9, end: 0.0),
                  child: SvgPicture.string(
                    _svg_tlyti8,
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          ),
          Pinned.fromPins(
            Pin(start: 6.0, end: -6.0),
            Pin(size: 383.0, start: 121.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xfffcfcff),
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(size: 104.0, end: -6.5),
            Pin(size: 20.0, middle: 0.1806),
            child: Text(
              'December 2018',
              style: TextStyle(
                fontFamily: 'SF Compact Display',
                fontSize: 15,
                color: const Color(0xffa5acb9),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 18.0, end: 24.8),
            Pin(size: 22.0, middle: 0.5127),
            child: Text(
              '29',
              style: TextStyle(
                fontFamily: 'SF Compact Display',
                fontSize: 17,
                color: const Color(0xffbec2c7),
                letterSpacing: 0.005100000202655792,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 18.0, middle: 0.7932),
            Pin(size: 22.0, middle: 0.5127),
            child: Text(
              '28',
              style: TextStyle(
                fontFamily: 'SF Compact Display',
                fontSize: 17,
                color: const Color(0xffbec2c7),
                letterSpacing: 0.005100000202655792,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 18.0, middle: 0.6559),
            Pin(size: 22.0, middle: 0.5127),
            child: Text(
              '27',
              style: TextStyle(
                fontFamily: 'SF Compact Display',
                fontSize: 17,
                color: const Color(0xff0c233c),
                letterSpacing: 0.005100000202655792,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 18.0, middle: 0.5186),
            Pin(size: 22.0, middle: 0.5127),
            child: Text(
              '26',
              style: TextStyle(
                fontFamily: 'SF Compact Display',
                fontSize: 17,
                color: const Color(0xff0c233c),
                letterSpacing: 0.005100000202655792,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 18.0, end: 24.8),
            Pin(size: 22.0, middle: 0.4544),
            child: Text(
              '22',
              style: TextStyle(
                fontFamily: 'SF Compact Display',
                fontSize: 17,
                color: const Color(0xffbec2c7),
                letterSpacing: 0.005100000202655792,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 18.0, middle: 0.7932),
            Pin(size: 22.0, middle: 0.4544),
            child: Text(
              '21',
              style: TextStyle(
                fontFamily: 'SF Compact Display',
                fontSize: 17,
                color: const Color(0x330c233c),
                letterSpacing: 0.005100000202655792,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 18.0, middle: 0.6559),
            Pin(size: 22.0, middle: 0.4544),
            child: Text(
              '20',
              style: TextStyle(
                fontFamily: 'SF Compact Display',
                fontSize: 17,
                color: const Color(0xff0c233c),
                letterSpacing: 0.005100000202655792,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 18.0, middle: 0.5186),
            Pin(size: 22.0, middle: 0.4544),
            child: Text(
              '19',
              style: TextStyle(
                fontFamily: 'SF Compact Display',
                fontSize: 17,
                color: const Color(0xff0c233c),
                letterSpacing: 0.005100000202655792,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 18.0, end: 24.8),
            Pin(size: 22.0, middle: 0.3962),
            child: Text(
              '15',
              style: TextStyle(
                fontFamily: 'SF Compact Display',
                fontSize: 17,
                color: const Color(0xffbec2c7),
                letterSpacing: 0.005100000202655792,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 18.0, middle: 0.7932),
            Pin(size: 22.0, middle: 0.3962),
            child: Text(
              '14',
              style: TextStyle(
                fontFamily: 'SF Compact Display',
                fontSize: 17,
                color: const Color(0xffbec2c7),
                letterSpacing: 0.005100000202655792,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 18.0, middle: 0.6559),
            Pin(size: 22.0, middle: 0.3962),
            child: Text(
              '13',
              style: TextStyle(
                fontFamily: 'SF Compact Display',
                fontSize: 17,
                color: const Color(0x330c233c),
                letterSpacing: 0.005100000202655792,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 18.0, middle: 0.5186),
            Pin(size: 22.0, middle: 0.3962),
            child: Text(
              '12',
              style: TextStyle(
                fontFamily: 'SF Compact Display',
                fontSize: 17,
                color: const Color(0xff0c233c),
                letterSpacing: 0.005100000202655792,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 9.0, end: 29.7),
            Pin(size: 22.0, middle: 0.338),
            child: Text(
              '8',
              style: TextStyle(
                fontFamily: 'SF Compact Display',
                fontSize: 17,
                color: const Color(0x330c233c),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 9.0, middle: 0.785),
            Pin(size: 22.0, middle: 0.338),
            child: Text(
              '7',
              style: TextStyle(
                fontFamily: 'SF Compact Display',
                fontSize: 17,
                color: const Color(0xffbec2c7),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 9.0, middle: 0.6512),
            Pin(size: 22.0, middle: 0.338),
            child: Text(
              '6',
              style: TextStyle(
                fontFamily: 'SF Compact Display',
                fontSize: 17,
                color: const Color(0xff0c233c),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 9.0, middle: 0.5173),
            Pin(size: 22.0, middle: 0.338),
            child: Text(
              '5',
              style: TextStyle(
                fontFamily: 'SF Compact Display',
                fontSize: 17,
                color: const Color(0xff0c233c),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 9.0, end: 29.7),
            Pin(size: 22.0, middle: 0.2797),
            child: Text(
              '1',
              style: TextStyle(
                fontFamily: 'SF Compact Display',
                fontSize: 17,
                color: const Color(0xffbec2c7),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Pinned.fromPins(
            Pin(start: 31.5, end: 25.5),
            Pin(size: 1.0, middle: 0.2571),
            child: SvgPicture.string(
              _svg_ly8h2,
              allowDrawingOutsideViewBox: true,
              fit: BoxFit.fill,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 7.0, middle: 0.5178),
            Pin(size: 19.0, middle: 0.2333),
            child: Text(
              'T',
              style: TextStyle(
                fontFamily: 'SF Compact Display',
                fontSize: 14,
                color: const Color(0xff107163),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 7.0, middle: 0.6568),
            Pin(size: 19.0, middle: 0.2333),
            child: Text(
              'F',
              style: TextStyle(
                fontFamily: 'SF Compact Display',
                fontSize: 14,
                color: const Color(0xff107163),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 7.0, middle: 0.7873),
            Pin(size: 19.0, middle: 0.2333),
            child: Text(
              'S',
              style: TextStyle(
                fontFamily: 'SF Compact Display',
                fontSize: 14,
                color: const Color(0x97606fee),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 7.0, end: 30.1),
            Pin(size: 19.0, middle: 0.2333),
            child: Text(
              'S',
              style: TextStyle(
                fontFamily: 'SF Compact Display',
                fontSize: 14,
                color: const Color(0x97606fee),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 128.0, middle: 0.5133),
            Pin(size: 24.0, middle: 0.1777),
            child: Text(
              'November 2018',
              style: TextStyle(
                fontFamily: 'SF Pro Display',
                fontSize: 18,
                color: const Color(0xff107163),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Pinned.fromPins(
            Pin(start: 6.5, end: -6.5),
            Pin(size: 1.0, start: 120.5),
            child: SvgPicture.string(
              _svg_qhk2ke,
              allowDrawingOutsideViewBox: true,
              fit: BoxFit.fill,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 90.0, start: -21.7),
            Pin(size: 20.0, middle: 0.1806),
            child: Text(
              'October 2018',
              style: TextStyle(
                fontFamily: 'SF Compact Display',
                fontSize: 15,
                color: const Color(0xffa5acb9),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 18.0, middle: 0.2441),
            Pin(size: 22.0, middle: 0.5709),
            child: Text(
              '31',
              style: TextStyle(
                fontFamily: 'SF Compact Display',
                fontSize: 17,
                color: const Color(0xff0c233c),
                letterSpacing: 0.005100000202655792,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 18.0, start: 38.2),
            Pin(size: 22.0, middle: 0.5709),
            child: Text(
              '30',
              style: TextStyle(
                fontFamily: 'SF Compact Display',
                fontSize: 17,
                color: const Color(0xff0c233c),
                letterSpacing: 0.005100000202655792,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 18.0, middle: 0.2441),
            Pin(size: 22.0, middle: 0.5127),
            child: Text(
              '24',
              style: TextStyle(
                fontFamily: 'SF Compact Display',
                fontSize: 17,
                color: const Color(0xff0c233c),
                letterSpacing: 0.005100000202655792,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 18.0, start: 38.2),
            Pin(size: 22.0, middle: 0.5127),
            child: Text(
              '23',
              style: TextStyle(
                fontFamily: 'SF Compact Display',
                fontSize: 17,
                color: const Color(0xff0c233c),
                letterSpacing: 0.005100000202655792,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 42.4, middle: 0.2218),
            Pin(size: 42.4, middle: 0.4558),
            child: SvgPicture.string(
              _svg_h9n8sy,
              allowDrawingOutsideViewBox: true,
              fit: BoxFit.fill,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 15.0, middle: 0.2421),
            Pin(size: 22.0, middle: 0.4544),
            child: Text(
              '17',
              style: TextStyle(
                fontFamily: 'SF Compact Display',
                fontSize: 17,
                color: const Color(0xffffffff),
                letterSpacing: 0.005100000202655792,
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 18.0, start: 38.2),
            Pin(size: 22.0, middle: 0.4544),
            child: Text(
              '16',
              style: TextStyle(
                fontFamily: 'SF Compact Display',
                fontSize: 17,
                color: const Color(0xff0c233c),
                letterSpacing: 0.005100000202655792,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 18.0, middle: 0.2441),
            Pin(size: 22.0, middle: 0.3962),
            child: Text(
              '10',
              style: TextStyle(
                fontFamily: 'SF Compact Display',
                fontSize: 17,
                color: const Color(0x330c233c),
                letterSpacing: 0.005100000202655792,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 9.0, start: 42.3),
            Pin(size: 22.0, middle: 0.3962),
            child: Text(
              '9',
              style: TextStyle(
                fontFamily: 'SF Compact Display',
                fontSize: 17,
                color: const Color(0xff0c233c),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 9.0, middle: 0.2495),
            Pin(size: 22.0, middle: 0.338),
            child: Text(
              '3',
              style: TextStyle(
                fontFamily: 'SF Compact Display',
                fontSize: 17,
                color: const Color(0xff0c233c),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 9.0, start: 42.3),
            Pin(size: 22.0, middle: 0.338),
            child: Text(
              '2',
              style: TextStyle(
                fontFamily: 'SF Compact Display',
                fontSize: 17,
                color: const Color(0xff0c233c),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 13.0, start: 42.9),
            Pin(size: 19.0, middle: 0.2333),
            child: Text(
              'M',
              style: TextStyle(
                fontFamily: 'SF Compact Display',
                fontSize: 14,
                color: const Color(0xff107163),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 7.0, middle: 0.2495),
            Pin(size: 19.0, middle: 0.2333),
            child: Text(
              'T',
              style: TextStyle(
                fontFamily: 'SF Compact Display',
                fontSize: 14,
                color: const Color(0xff107163),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 18.0, middle: 0.3814),
            Pin(size: 22.0, middle: 0.5127),
            child: Text(
              '25',
              style: TextStyle(
                fontFamily: 'SF Compact Display',
                fontSize: 17,
                color: const Color(0xff0c233c),
                letterSpacing: 0.005100000202655792,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 18.0, middle: 0.3814),
            Pin(size: 22.0, middle: 0.4544),
            child: Text(
              '18',
              style: TextStyle(
                fontFamily: 'SF Compact Display',
                fontSize: 17,
                color: const Color(0x330c233c),
                letterSpacing: 0.005100000202655792,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 18.0, middle: 0.3814),
            Pin(size: 22.0, middle: 0.3962),
            child: Text(
              '11',
              style: TextStyle(
                fontFamily: 'SF Compact Display',
                fontSize: 17,
                color: const Color(0xff0c233c),
                letterSpacing: 0.005100000202655792,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 9.0, middle: 0.3834),
            Pin(size: 22.0, middle: 0.338),
            child: Text(
              '4',
              style: TextStyle(
                fontFamily: 'SF Compact Display',
                fontSize: 17,
                color: const Color(0xff0c233c),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Pinned.fromPins(
            Pin(size: 13.0, middle: 0.3943),
            Pin(size: 19.0, middle: 0.2333),
            child: Text(
              'W',
              style: TextStyle(
                fontFamily: 'SF Compact Display',
                fontSize: 14,
                color: const Color(0xff107163),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}

const String _svg_t5al53 =
    '<svg viewBox="37.0 478.3 4.0 4.2" ><path transform="translate(-890.0, 0.0)" d="M 927 478.3497619628906 L 927 482.5000610351562 L 930.9560546875 482.5000610351562" fill="none" stroke="#200e32" stroke-width="1" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_aytwr =
    '<svg viewBox="37.0 478.3 4.0 4.2" ><path transform="translate(-890.0, 0.0)" d="M 927 478.3497619628906 L 927 482.5000610351562 L 930.9560546875 482.5000610351562" fill="none" stroke="#ffffff" stroke-width="1" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_l46t =
    '<svg viewBox="31.5 40.2 16.6 1.0" ><path transform="translate(0.8, 4.0)" d="M 30.69856643676758 36.22430801391602 L 47.27579116821289 36.22430801391602" fill="none" stroke="#107163" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_komme =
    '<svg viewBox="31.5 34.3 5.9 5.9" ><path transform="matrix(0.707107, -0.707107, 0.707107, 0.707107, -15.82, 36.25)" d="M 30.69856643676758 36.22430801391602 L 38.98717880249023 36.22430801391602" fill="none" stroke="#107163" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_tlyti8 =
    '<svg viewBox="31.5 40.3 5.9 5.9" ><path transform="matrix(0.707107, 0.707107, -0.707107, 0.707107, 35.41, -7.03)" d="M 30.69856643676758 36.22430801391602 L 38.98717880249023 36.22430801391602" fill="none" stroke="#107163" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="round" /></svg>';
const String _svg_ly8h2 =
    '<svg viewBox="31.5 208.5 318.0 1.0" ><path transform="translate(31.0, 207.0)" d="M 0.5 1.5 L 318.5 1.5" fill="#606fee" fill-opacity="0.12" stroke="#606fee" stroke-width="1" stroke-opacity="0.12" stroke-miterlimit="4" stroke-linecap="square" /></svg>';
const String _svg_qhk2ke =
    '<svg viewBox="6.5 120.5 375.0 1.0" ><path transform="translate(6.5, 120.5)" d="M 0 1 L 375 0" fill="none" stroke="#606fee" stroke-width="1" stroke-opacity="0.12" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_h9n8sy =
    '<svg viewBox="73.8 350.8 42.4 42.4" ><path transform="translate(-2963.22, 2677.78)" d="M 3058.2236328125 -2284.552734375 C 3069.94482421875 -2284.552734375 3079.447265625 -2294.055419921875 3079.447265625 -2305.7763671875 C 3079.447265625 -2317.49755859375 3069.94482421875 -2327 3058.2236328125 -2327 C 3046.5029296875 -2327 3037 -2317.49755859375 3037 -2305.7763671875 C 3037 -2294.055419921875 3046.5029296875 -2284.552734375 3058.2236328125 -2284.552734375 Z" fill="#107163" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
