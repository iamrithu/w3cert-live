import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../const/const.dart';

class CustomListview extends StatefulWidget {
  final double width;
  final double height;
  final String asset;
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
        Container(
          alignment: Alignment.center,
          height: widget.height * 0.05,
          margin: EdgeInsets.only(bottom: 1),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: GlobalColors.light, width: 1))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                widget.asset,
                width:
                    widget.width < 500 ? widget.width / 20 : widget.width / 40,
              ),
              Container(
                width: widget.width * 0.4,
                child: Text(widget.content,
                    style: GoogleFonts.josefinSans(
                        color: GlobalColors.dark,
                        fontSize: widget.width < 500
                            ? widget.width / 30
                            : widget.width / 50)),
              ),
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
      ],
    );
  }
}
