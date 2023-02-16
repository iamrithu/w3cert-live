// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:w3cert/const/const.dart';
import 'package:w3cert/provider/providers.dart';

import '../../models/attendenceModel.dart';
import '../../router/routing-const.dart';
import '../../widgets/custom-drawer.dart';

const List<String> action = [
  'Present',
  'Absent',
];

class Attendence extends ConsumerStatefulWidget {
  const Attendence({Key? key}) : super(key: key);

  @override
  _AttendenceState createState() => _AttendenceState();
}

class _AttendenceState extends ConsumerState<Attendence> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  DateTime curDate = DateTime.now();
  // Create a ke
  final List<bool> _selectedaction = <bool>[
    true,
    false,
  ];

  String? attendanceAction = action[0];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final data = ref.watch(attendenceProvider);
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
          elevation: 0,
          title: Row(
            children: [
              Text(
                "Attendence",
                style: GoogleFonts.ptSans(
                    color: GlobalColors.white,
                    fontSize: width < 500 ? width / 25 : width / 35),
              ),
              Container(
                height: height * 0.02,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                decoration: BoxDecoration(
                    color: DateFormat("dd-MM-yyyy").format(DateTime.now()) ==
                            ref.watch(attendenceDate)
                        ? Color.fromARGB(255, 225, 241, 255)
                        : Color.fromARGB(255, 255, 221, 219),
                    borderRadius: BorderRadius.circular(2)),
                child: Text(
                  DateFormat("dd-MM-yyyy").format(DateTime.now()) ==
                          ref.watch(attendenceDate)
                      ? " Today : ${ref.watch(attendenceDate)}"
                      : "${ref.watch(attendenceDate)}",
                  style: GoogleFonts.ptSans(
                      color: DateFormat("dd-MM-yyyy").format(DateTime.now()) ==
                              ref.watch(attendenceDate)
                          ? GlobalColors.blue
                          : GlobalColors.red,
                      fontSize: width < 500 ? width / 35 : width / 50),
                ),
              ),
            ],
          ),
          actions: [
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
                      (state) => "${DateFormat("dd-MM-yyyy").format(curDate)}");
                });
                return ref.refresh(attendenceProvider);
              },
              icon: Icon(
                Icons.calendar_month,
                color: GlobalColors.white,
                size: width < 500 ? width / 25 : width / 50,
              ),
            ),
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
          child: Column(
            children: [
              Container(
                width: width,
                height: width < 500 ? height * 0.05 : height * 0.065,
                color: GlobalColors.white,
                child: ToggleButtons(
                  onPressed: (int index) {
                    setState(() {
                      attendanceAction = action[index];
                      // The button that is tapped is set to true, and the others to false.
                      for (int i = 0; i < _selectedaction.length; i++) {
                        _selectedaction[i] = i == index;
                      }
                    });
                  },
                  selectedColor: Colors.white,
                  fillColor: GlobalColors.themeColor,
                  color: GlobalColors.themeColor,
                  constraints: BoxConstraints(
                      minHeight: width < 500 ? 40.0 : 80,
                      minWidth: width * 0.495),
                  isSelected: _selectedaction,
                  children: action.map((e) => Text(e)).toList(),
                ),
              ),
              Flexible(
                  child: data.when(data: (_data) {
                List<AttendenceModel> present = [];
                List<AttendenceModel> absent = [];
                for (var i = 0; i < _data.length; i++) {
                  if (_data[i].clockInTime != null) {
                    present.add(_data[i]);
                  } else {
                    absent.add(_data[i]);
                  }
                }
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      if (attendanceAction == "Present")
                        for (var i = 0; i < present.length; i++)
                          if (present[i].name != "Richard C" &&
                              present[i].name != "Robinson")
                            Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  side: BorderSide(
                                      color: Color.fromARGB(255, 155, 202, 244),
                                      width: 0.5)),
                              child: Container(
                                width: width,
                                height:
                                    width < 500 ? height * 0.07 : height * 0.09,
                                padding: EdgeInsets.only(bottom: 1),
                                child: Row(
                                  children: [
                                    Container(
                                      width: width < 500
                                          ? width * 0.13
                                          : width * 0.09,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: width * 0.02),
                                      child: Card(
                                        elevation: 10,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                width * 0.5)),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              width * 0.5),
                                          child: Image.network(
                                            present[i].imageUrl!,
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
                                                "${present[i].name!}",
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
                                                  "${present[i].designationName}",
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
                                                margin:
                                                    EdgeInsets.only(right: 4),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          width * 0.5),
                                                  color: GlobalColors.green,
                                                ),
                                              ),
                                              Text(
                                                "Present",
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
                                      child: Center(
                                          child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: GlobalColors.light,
                                        size: width < 500
                                            ? width / 35
                                            : width / 55,
                                      )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                      if (attendanceAction == "Absent")
                        for (var i = 0; i < absent.length; i++)
                          if (absent[i].name != "Richard C" &&
                              absent[i].name != "Robinson")
                            Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  side: BorderSide(
                                      color: Color.fromARGB(255, 155, 202, 244),
                                      width: 0.5)),
                              child: Container(
                                width: width,
                                height:
                                    width < 500 ? height * 0.07 : height * 0.09,
                                padding: EdgeInsets.only(bottom: 1),
                                child: Row(
                                  children: [
                                    Container(
                                      width: width < 500
                                          ? width * 0.13
                                          : width * 0.09,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: width * 0.02),
                                      child: Card(
                                        elevation: 10,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                width * 0.5)),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              width * 0.5),
                                          child: Image.network(
                                            absent[i].imageUrl!,
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
                                                "${absent[i].name!}",
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
                                                  "${absent[i].designationName}",
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
                                                margin:
                                                    EdgeInsets.only(right: 4),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          width * 0.5),
                                                  color: GlobalColors.red,
                                                ),
                                              ),
                                              Text(
                                                "Absent",
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
                                      child: Center(
                                          child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: GlobalColors.light,
                                        size: width < 500
                                            ? width / 35
                                            : width / 55,
                                      )),
                                    ),
                                  ],
                                ),
                              ),
                            )
                    ],
                  ),
                );
              }, error: (e, s) {
                return Text(e.toString());
              }, loading: () {
                return Center(child: CircularProgressIndicator.adaptive());
              }))
            ],
          ),
        ),
      ),
    );
  }
}
