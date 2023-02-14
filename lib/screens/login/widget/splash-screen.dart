import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool animated = false;

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 500), (() {
      setState(() {
        animated = true;
      });
    }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      child: Center(
        child: AnimatedContainer(
          width: animated
              ? width < 500
                  ? width * 0.4
                  : width * 0.2
              : width * 0.00,
          height: animated ? width * 0.4 : width * 0.00,
          alignment: Alignment.center,
          duration: const Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
          child: Opacity(
            opacity: animated ? 1 : 0,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(width * 0.5)),
              elevation: 10,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(width * 0.5),
                child: Image(
                  image: AssetImage("Assets/icon.jpg"),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
