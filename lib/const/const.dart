import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Map<int, Color> color = {
  50: Color.fromRGBO(8, 28, 46, .1),
  100: Color.fromRGBO(8, 28, 46, .2),
  200: Color.fromRGBO(8, 28, 46, .3),
  300: Color.fromRGBO(8, 28, 46, .4),
  400: Color.fromRGBO(8, 28, 46, .5),
  500: Color.fromRGBO(8, 28, 46, .6),
  600: Color.fromRGBO(8, 28, 46, .7),
  700: Color.fromRGBO(8, 28, 46, .8),
  800: Color.fromRGBO(8, 28, 46, .9),
  900: Color(0xFF081C2E),
};
MaterialColor colorCustom = const MaterialColor(0xFF081C2E, color);

class BaseUrl {
  static const url = "https://portal.w3cert.in/api/";
}

class GlobalColors {
  static MaterialColor materialColor = colorCustom;
  static const themeColor = Color.fromRGBO(8, 28, 46, 1);
  static const dark = Color.fromRGBO(0, 0, 0, 1);
  static const white = Color.fromRGBO(255, 255, 255, 1);
  static const light = Color.fromRGBO(82, 81, 81, 1);
  static const red = Colors.red;
  static const blue = Colors.blue;

  static const orange = Colors.orange;
  static const green = Colors.green;
  static const yellow = Colors.yellow;
}

customAlert(context, width, height, success, content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 10,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: success
                ? Color.fromARGB(255, 231, 250, 231)
                : Color.fromARGB(255, 250, 233, 232),
          ),
          width: width * 0.5,
          height: width < 500 ? height * 0.08 : height * 0.06,
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(2),
                child: !success
                    ? Image.asset('Assets/error.png')
                    : Image.asset('Assets/success.png'),
              ),
              SizedBox(width: width * 0.05),
              Flexible(
                child: Text(
                  content,
                  style: GoogleFonts.josefinSans(
                    color: !success ? GlobalColors.red : GlobalColors.green,
                    fontSize: width < 500 ? width / 30 : width / 45,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      duration: Duration(milliseconds: 2000),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
  );
}
