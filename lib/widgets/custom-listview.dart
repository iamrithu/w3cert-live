import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../const/const.dart';

class CustomListview extends StatefulWidget {
  final double width;
  final double height;
  final IconData asset;
  final String content;

  const CustomListview(
      {Key? key,
      required this.width,
      required this.height,
      required this.asset,
      required this.content})
      : super(key: key);

  @override
  State<CustomListview> createState() => _CustomListviewState();
}

class _CustomListviewState extends State<CustomListview> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
              side: BorderSide(
                  color: Color.fromARGB(255, 155, 202, 244), width: 0.5)),
          child: Container(
            alignment: Alignment.center,
            height: widget.height * 0.05,
            color: Color.fromARGB(255, 232, 241, 249),
            margin: EdgeInsets.only(bottom: 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                      side: BorderSide(
                          color: Color.fromARGB(255, 155, 202, 244),
                          width: 0.5)),
                  child: Container(
                    margin: EdgeInsets.all(4),
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Color.fromARGB(255, 52, 158, 250),
                    ),

                    // color: Color.fromARGB(255, 216, 232, 255),
                    width: widget.width < 500
                        ? widget.width * 0.07
                        : widget.width * 0.05,
                    height: widget.width < 500
                        ? widget.width * 0.07
                        : widget.width * 0.05,
                    child: Center(
                        child: FaIcon(
                      widget.asset,
                      color: GlobalColors.white,
                      size: widget.width < 500
                          ? widget.width * 0.035
                          : widget.width * 0.025,
                    )),
                  ),
                ),
                Container(
                  width: widget.width < 500
                      ? widget.width * 0.5
                      : widget.width * 0.3,
                  child: Text(widget.content,
                      style: GoogleFonts.montserrat(
                          color: GlobalColors.themeColor,
                          fontWeight: FontWeight.w500,
                          fontSize: widget.width < 500
                              ? widget.width / 35
                              : widget.width / 50)),
                ),
                if (false == true)
                  Container(
                    width: widget.width * 0.1,
                    child: Icon(Icons.arrow_forward_rounded,
                        size: widget.width < 500
                            ? widget.width / 30
                            : widget.width / 45),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
