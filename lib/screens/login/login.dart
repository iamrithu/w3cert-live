// ignore_for_file: library_private_types_in_public_api, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider/providers.dart';
import 'widget/login-screen.dart';
import 'widget/splash-screen.dart';

class Login extends ConsumerStatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), (() {
      ref.watch(splashProvider.notifier).update((state) => false);
    }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        padding: EdgeInsets.all(width * 0.05),
        child: ref.watch(splashProvider)
            ? const SplashScreen()
            : const LoginScreen(),
      ),
    );
  }
}
