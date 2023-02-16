// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:w3cert/const/const.dart';
import 'package:w3cert/provider/providers.dart';

import '../../widgets/custom-drawer.dart';

class NotificationScreen extends ConsumerStatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a ke

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final data = ref.watch(notificationProvider);

    return SafeArea(
      child: Scaffold(
        key: _key,
        floatingActionButton: width < 500
            ? null
            : FloatingActionButton(
                onPressed: () => _key.currentState!.openDrawer(),
                child: Icon(Icons.menu), // <-- Opens drawer
              ),
        appBar: AppBar(
          title: Text(
            "Notifications",
            style: GoogleFonts.ptSans(
                color: GlobalColors.white,
                fontSize: width < 500 ? width / 25 : width / 35),
          ),
        ),
        drawer: Drawer(
          elevation: 10,
          width: width < 500 ? width * 0.7 : width * 0.4,
          child: CustomDrawer(
            width: width,
            height: height,
          ),
        ),
        body: Container(
          height: height,
          width: width,
          child: data.when(data: (_data) {
            return ListView.builder(
                itemCount: _data.length,
                itemBuilder: (context, i) {
                  return InkWell(
                    onTap: () {
                      print("rithi");
                    },
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                          side: BorderSide(
                              color: Color.fromARGB(255, 155, 202, 244),
                              width: 0.5)),
                      child: Container(
                        width: width,
                        height: height * 0.07,
                        padding: EdgeInsets.only(bottom: 1),
                        // decoration: BoxDecoration(
                        //   border: Border(
                        //     bottom: BorderSide(color: GlobalColors.light),
                        //   ),
                        // ),
                        child: Row(
                          children: [
                            Container(
                              width: width * 0.13,
                              margin: EdgeInsets.symmetric(
                                  horizontal: width * 0.02),
                              child: Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(width * 0.5)),
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(width * 0.5),
                                  child: Image.network(
                                    _data[i].image!,
                                    width: width * 0.1,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: width * 0.5,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          "${_data[i].text ?? "--"}",
                                          style: GoogleFonts.ptSans(
                                              color: GlobalColors.dark,
                                              fontSize: width < 500
                                                  ? width / 35
                                                  : width / 55),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: width * 0.3,
                                        child: Text(
                                          "${_data[i].subject ?? "--"}",
                                          style: GoogleFonts.ptSans(
                                              color: GlobalColors.light,
                                              fontSize: width < 500
                                                  ? width / 35
                                                  : width / 55),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: width * 0.2,
                              alignment: Alignment.centerRight,
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: GlobalColors.light,
                                size: width < 500 ? width / 35 : width / 55,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
            // return SingleChildScrollView(
            //   child: Column(
            //     children: [
            //       for (var i = 0; i < _data.length; i++)
            //         Card(
            //           child: Container(
            //             width: width,
            //             height: height * 0.07,
            //             padding: EdgeInsets.only(bottom: 1),
            //             decoration: BoxDecoration(
            //               border: Border(
            //                 bottom: BorderSide(color: GlobalColors.light),
            //               ),
            //             ),
            //             child: Row(
            //               children: [
            //                 Container(
            //                   width: width * 0.13,
            //                   margin: EdgeInsets.symmetric(
            //                       horizontal: width * 0.02),
            //                   child: Card(
            //                     elevation: 10,
            //                     shape: RoundedRectangleBorder(
            //                         borderRadius:
            //                             BorderRadius.circular(width * 0.5)),
            //                     child: ClipRRect(
            //                       borderRadius:
            //                           BorderRadius.circular(width * 0.5),
            //                       child: Image.network(
            //                         _data[i].image!,
            //                         width: width * 0.1,
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //                 Container(
            //                   width: width * 0.5,
            //                   child: Column(
            //                     mainAxisAlignment:
            //                         MainAxisAlignment.spaceEvenly,
            //                     children: [
            //                       Row(
            //                         children: [
            //                           Flexible(
            //                             child: Text(
            //                               "${_data[i].text ?? "--"}",
            //                               style: GoogleFonts.ptSans(
            //                                   color: GlobalColors.dark,
            //                                   fontSize: width < 500
            //                                       ? width / 35
            //                                       : width / 55),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                       Row(
            //                         crossAxisAlignment:
            //                             CrossAxisAlignment.center,
            //                         children: [
            //                           Container(
            //                             width: width * 0.3,
            //                             child: Text(
            //                               "${_data[i].subject ?? "--"}",
            //                               style: GoogleFonts.ptSans(
            //                                   color: GlobalColors.light,
            //                                   fontSize: width < 500
            //                                       ? width / 35
            //                                       : width / 55),
            //                             ),
            //                           ),
            //                         ],
            //                       )
            //                     ],
            //                   ),
            //                 ),
            //                 Container(
            //                   width: width * 0.2,
            //                   alignment: Alignment.centerRight,
            //                   child: Icon(
            //                     Icons.arrow_forward_ios,
            //                     color: GlobalColors.light,
            //                     size: width < 500 ? width / 35 : width / 55,
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //     ],
            //   ),
            // );
          }, error: (e, s) {
            return Text(e.toString());
          }, loading: () {
            return Center(child: CircularProgressIndicator.adaptive());
          }),
        ),
      ),
    );
  }
}
