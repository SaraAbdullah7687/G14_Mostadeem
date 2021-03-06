import 'package:flutter/material.dart';
//import 'package:mostadeem/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocalIcon extends StatelessWidget {
  final String iconSrc;
  final Function press;
  final Color color;
  const SocalIcon({
    Key key,
    this.iconSrc,
    this.press,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
      // margin: EdgeInsets.symmetric(horizontal:10),
      //  padding: EdgeInsets.all(3),
      /*  decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: color,
          ),
          shape: BoxShape.circle,
        ),*/
        child: SvgPicture.asset(
          iconSrc,
          height: 20,
         // width: 20,
          color:color,
        ),
      ),
    );
  }
}






class SocialIcon extends StatelessWidget {
  final String iconSrc;
  final Function press;
  final Color color;
  const SocialIcon({
    Key key,
    this.iconSrc,
    this.press,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
      // margin: EdgeInsets.symmetric(horizontal:10),
      //  padding: EdgeInsets.all(3),
      /*  decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: color,
          ),
          shape: BoxShape.circle,
        ),*/
        child: SvgPicture.asset(
          iconSrc,
          height: 40,
         // width: 20,
          color:color,
        ),
      ),
    );
  }
}