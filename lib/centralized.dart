import 'package:flutter/material.dart'
    show
        BuildContext,
        Color,
        FontWeight,
        Key,
        StatelessWidget,
        Text,
        TextStyle,
        Widget;

//All colors
const background = Color(0xffCAEEFF);
const white = Color(0xffFFFFFF);
const darkblue = Color(0xff1D71B9);
const blue = Color(0xff36A9E0);
const hint = Color(0xffA5A4A4);
const black = Color(0xff000000);

//All Bold fonts
class BoldFont extends StatelessWidget {
  final String text;
  final double size;
  final Color color;

  const BoldFont(this.text, this.size, this.color, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        fontWeight: FontWeight.w600,
        fontFamily: "Poppins",
        color: color,
      ),
    );
  }
}

//All normal fonts
class PlainFont extends StatelessWidget {
  final String text;
  final double size;
  final Color color;

  const PlainFont(this.text, this.size, this.color, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        fontWeight: FontWeight.w400,
        fontFamily: "Poppins",
        color: color,
      ),
    );
  }
}
