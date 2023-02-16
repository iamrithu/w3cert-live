import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:w3cert/api/api.dart';

import '../../../const/const.dart';
import '../../../provider/providers.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      // Thumb icon when the switch is selected.
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );
  bool isSelected = false;
  bool autoLogin = false;

  bool passwordVisibility = true;

  isselect() async {
    final prefs = await SharedPreferences.getInstance();
    final bool? repeat = prefs.getBool('repeat');
    final String? newEmail = prefs.getString("email");
    final String? newPassword = prefs.getString("password");

    setState(() {
      isSelected = repeat!;
    });

    if (isSelected) {
      setState(() {
        _email.text = newEmail!;
        _password.text = newPassword!;
        autoLogin = true;
      });
    }
  }

  saveCredential(String? email, String? password, bool selected) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email!);
    await prefs.setString('password', password!);
    await prefs.setBool("repeat", selected);
  }

  @override
  void initState() {
    super.initState();
    isselect();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    login(context, width, height) async {
      Api().authendication(_email.text, _password.text).then((value) {
        if (value.statusCode != 200) {
          return customAlert(context, width, height, false,
              "${value.data["error"]["message"]}");
        }

        if (isSelected) {
          saveCredential(_email.text, _password.text, isSelected);
        } else {
          saveCredential("", "", isSelected);
        }
        ref.watch(email.notifier).update((state) => _email.text);
        ref.watch(password.notifier).update((state) => _password.text);
        ref
            .watch(tokenProvider.notifier)
            .update((state) => value.data["data"]["token"]);

        ref.watch(loggedInProvider.notifier).update((state) => true);
        customAlert(context, width, height, true,
            "Hi ,${value.data["data"]["user"]["name"]}");
        return null;
      });
    }

    if (autoLogin) {
      login(context, width, height);
    }

    return Container(
      width: width,
      height: height,
      alignment: Alignment.bottomCenter,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              width: width,
              height: height * 0.3767,
              alignment: Alignment.bottomCenter,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(
                  image: AssetImage("Assets/icon.jpg"),
                  width: width < 500 ? width * 0.5 : width * 0.2,
                ),
              ),
            ),
            Container(
              width: width,
              height: height * 0.4767,
              alignment: Alignment.center,
              child: Column(children: [
                SizedBox(
                  height: height * 0.05,
                ),
                Container(
                  width: width < 500 ? width : width * 0.5,
                  child: TextFormField(
                    controller: _email,
                    decoration: InputDecoration(
                      labelText: 'Email *',
                    ),
                    onSaved: (String? value) {},
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Container(
                  width: width < 500 ? width : width * 0.5,
                  child: TextFormField(
                    controller: _password,
                    obscureText: passwordVisibility,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              passwordVisibility = !passwordVisibility;
                            });
                          },
                          icon: !passwordVisibility
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off)),
                      labelText: 'Password *',
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  width: width < 500 ? width : width * 0.55,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: width * 0.1,
                        child: Switch(
                          thumbIcon: thumbIcon,
                          value: isSelected,
                          onChanged: (bool value) async {
                            // Obtain shared preferences.
                            setState(() {
                              isSelected = value;
                            });
                          },
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        width: width * 0.45,
                        child: Text(
                          'Stay logged in',
                          style: GoogleFonts.ptSans(
                              fontSize: width < 500 ? width / 35 : width / 60),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      backgroundColor: GlobalColors.green,
                      minimumSize: Size(
                          width < 500 ? width : width * 0.5, height * 0.04)),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      login(context, width, height);
                      // customAlert(context, width, height, true, "Hi there!");
                    }
                  },
                  child: Container(
                    width: width < 500 ? width * 0.2 : width * 0.1,
                    height: width < 500 ? height * 0.065 : height * 0.05,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Log In',
                          style: GoogleFonts.ptSans(
                              fontSize: width < 500 ? width / 30 : width / 40),
                        ),
                        Icon(Icons.arrow_circle_right_outlined)
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
