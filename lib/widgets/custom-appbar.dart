import 'package:flutter/material.dart';

class CustomAppbar extends StatefulWidget {
  const CustomAppbar({Key? key}) : super(key: key);

  @override
  _CustomAppbarState createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: Container(
            color: Colors.white,
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search",
                contentPadding: EdgeInsets.all(10),
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.verified_user),
              onPressed: () => null,
            ),
          ],
        ),
      ],
    );
    ;
  }
}
