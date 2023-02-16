// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:w3cert/const/const.dart';
import 'package:w3cert/provider/providers.dart';

import '../../router/routing-const.dart';
import '../../widgets/custom-drawer.dart';

class Employee extends ConsumerStatefulWidget {
  const Employee({Key? key}) : super(key: key);

  @override
  _EmployeeState createState() => _EmployeeState();
}

class _EmployeeState extends ConsumerState<Employee> {
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a ke

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final data = ref.watch(employeProvider);

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
            "Employees",
            style: GoogleFonts.ptSans(
                color: GlobalColors.white,
                fontSize: width < 500 ? width / 25 : width / 35),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  context.pushReplacementNamed(RoutingConstants.notifications);
                },
                icon: Icon(Icons.notifications_active_outlined))
          ],
        ),
        drawer: Drawer(
          elevation: 10,
          width: width < 500 ? width * 0.7 : width * 0.5,
          child: CustomDrawer(
            width: width,
            height: height,
          ),
        ),
        body: Container(
          height: height,
          width: width,
          child: data.when(data: (_data) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  for (var i = 0; i < _data.length; i++)
                    Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                          side: BorderSide(
                              color: Color.fromARGB(255, 155, 202, 244),
                              width: 0.5)),
                      child: Container(
                        width: width,
                        height: width < 500 ? height * 0.07 : height * 0.09,
                        padding: EdgeInsets.only(bottom: 1),
                        child: Row(
                          children: [
                            Container(
                              width: width < 500 ? width * 0.13 : width * 0.07,
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
                                    _data[i].imageUrl!,
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
                                      Text(
                                        "${_data[i].name!}",
                                        style: GoogleFonts.ptSans(
                                            color: GlobalColors.dark,
                                            fontSize: width < 500
                                                ? width / 35
                                                : width / 55),
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
                                          "${_data[i].designationName}",
                                          style: GoogleFonts.ptSans(
                                              color: GlobalColors.light,
                                              fontSize: width < 500
                                                  ? width / 35
                                                  : width / 55),
                                        ),
                                      ),
                                      Container(
                                        width: 8,
                                        height: 8,
                                        margin: EdgeInsets.only(right: 4),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              width * 0.5),
                                          color: GlobalColors.green,
                                        ),
                                      ),
                                      Text(
                                        "Active",
                                        style: GoogleFonts.ptSans(
                                            color: GlobalColors.dark,
                                            fontSize: width < 500
                                                ? width / 35
                                                : width / 55),
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
                ],
              ),
            );
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
