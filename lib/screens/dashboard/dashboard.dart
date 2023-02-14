// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:w3cert/const/const.dart';
import 'package:w3cert/models/attendenceModel.dart';
import 'package:w3cert/provider/providers.dart';
import 'package:w3cert/router/routing-const.dart';

import '../../widgets/custom-drawer.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  DateTime curDate = DateTime.now(); // Create a key

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    setState(() {
      curDate = DateTime.now();
      ref
          .watch(attendenceDate.notifier)
          .update((state) => "${DateFormat("dd-MM-yyyy").format(curDate)}");
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
            "Dashboard",
            style: GoogleFonts.josefinSans(
                color: GlobalColors.white,
                fontSize: width < 500 ? width / 25 : width / 35),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  context.pushNamed(RoutingConstants.notifications);
                },
                icon: Icon(Icons.notifications_active_outlined))
          ],
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
          margin: EdgeInsets.all(5),
          child: Column(
            children: [
              Card(
                elevation: 10,
                child: Container(
                  width: width,
                  height: height * 0.2,
                  child: Column(
                    children: [
                      Container(
                        width: width,
                        height: height * 0.05,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4),
                              topRight: Radius.circular(4)),
                          color: GlobalColors.orange,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Attendence",
                                  style: GoogleFonts.josefinSans(
                                      color: GlobalColors.white,
                                      fontSize: width < 500
                                          ? width / 30
                                          : width / 50),
                                ),
                                Container(
                                  height: height * 0.02,
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 2),
                                  decoration: BoxDecoration(
                                      color: DateFormat("dd-MM-yyyy")
                                                  .format(DateTime.now()) ==
                                              ref.watch(attendenceDate)
                                          ? Color.fromARGB(255, 250, 239, 214)
                                          : Color.fromARGB(255, 255, 221, 219),
                                      borderRadius: BorderRadius.circular(2)),
                                  child: Text(
                                    DateFormat("dd-MM-yyyy")
                                                .format(DateTime.now()) ==
                                            ref.watch(attendenceDate)
                                        ? " Today : ${ref.watch(attendenceDate)}"
                                        : "${ref.watch(attendenceDate)}",
                                    style: GoogleFonts.josefinSans(
                                        color: DateFormat("dd-MM-yyyy")
                                                    .format(DateTime.now()) ==
                                                ref.watch(attendenceDate)
                                            ? GlobalColors.orange
                                            : GlobalColors.red,
                                        fontSize: width < 500
                                            ? width / 35
                                            : width / 50),
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {
                                showDatePicker(
                                  currentDate: curDate,
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime.now(),
                                ).then((DateTime? value) {
                                  if (value == null) return null;
                                  setState(() {
                                    curDate = value;
                                  });
                                  ref.watch(attendenceDate.notifier).update(
                                      (state) =>
                                          "${DateFormat("dd-MM-yyyy").format(curDate)}");
                                });
                                return ref.refresh(attendenceProvider);
                              },
                              icon: Icon(
                                Icons.calendar_month,
                                color: GlobalColors.white,
                                size: width < 500 ? width / 25 : width / 50,
                              ),
                            )
                          ],
                        ),
                      ),
                      Consumer(
                        builder: (context, ref, child) {
                          final data = ref.watch(attendenceProvider);

                          return data.when(data: (_data) {
                            List<AttendenceModel> present = [];
                            List<AttendenceModel> absent = [];
                            for (var i = 0; i < _data.length; i++) {
                              if (_data[i].clockInTime != null) {
                                present.add(_data[i]);
                              } else {
                                absent.add(_data[i]);
                              }
                            }
                            return Flexible(
                                child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Present(${present.length})",
                                    style: GoogleFonts.josefinSans(
                                        color: GlobalColors.dark,
                                        fontSize: width < 500
                                            ? width / 35
                                            : width / 50,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  new LinearPercentIndicator(
                                    width: width * 0.8,
                                    animation: true,
                                    lineHeight: 4.0,
                                    percent: present.length / _data.length,
                                    backgroundColor:
                                        Color.fromARGB(255, 207, 249, 208),
                                    barRadius: Radius.circular(100),
                                    progressColor: GlobalColors.green,
                                  ),
                                  Text(
                                    "Absent(${absent.length})",
                                    style: GoogleFonts.josefinSans(
                                        color: GlobalColors.dark,
                                        fontSize: width < 500
                                            ? width / 35
                                            : width / 50,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  new LinearPercentIndicator(
                                    width: width * 0.8,
                                    animation: true,
                                    lineHeight: 4.0,
                                    percent: absent.length / _data.length,
                                    barRadius: Radius.circular(100),
                                    backgroundColor:
                                        Color.fromARGB(255, 244, 215, 213),
                                    progressColor: Colors.red,
                                  ),
                                ],
                              ),
                            ));
                          }, error: (error, stackTrace) {
                            return Text(error.toString());
                          }, loading: () {
                            return Center(
                              child: CircularProgressIndicator.adaptive(),
                            );
                          });
                        },
                      ),
                      Container(
                        width: width,
                        height: height * 0.05,
                        padding: EdgeInsets.only(top: 0.5, left: 10),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    color: GlobalColors.light, width: 0.5))),
                        child: InkWell(
                          onTap: () {
                            context.pushNamed(RoutingConstants.attendence);
                          },
                          child: Text(
                            "View Full Attendence ->",
                            style: GoogleFonts.josefinSans(
                                color: GlobalColors.light,
                                fontSize: width < 500 ? width / 40 : width / 50,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Card(
                child: Container(
                  width: width,
                  height: height * 0.05,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
