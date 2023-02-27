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
                "Attendance",
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
                            InkWell(
                              onTap: () {
                                showDialog<void>(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              child: Image.network(
                                                present[i].imageUrl!,
                                                width: width < 500
                                                    ? width / 8
                                                    : width / 45,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(),
                                              child: Text(
                                                "${present[i].name}",
                                                style: GoogleFonts.ptSans(
                                                    color: GlobalColors.light,
                                                    fontSize: width < 500
                                                        ? width / 28
                                                        : width / 55),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Row(
                                              children: [
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
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: width < 500
                                                          ? width / 40
                                                          : width / 55),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      content: Container(
                                        width: width,
                                        constraints: BoxConstraints(
                                            minHeight: height * 0.2,
                                            minWidth: width),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Divider(),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: width * 0.25,
                                                    child: Text(
                                                      "ClockIn",
                                                      style: GoogleFonts.ptSans(
                                                          color: GlobalColors
                                                              .light,
                                                          fontSize: width < 500
                                                              ? width / 35
                                                              : width / 55),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: width * 0.45,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "${present[i].clockInTime == null ? "--" : DateTime.parse(
                                                          present[i]
                                                              .clockInTime,
                                                        ).add(DateTime.parse(present[i].clockInTime).timeZoneOffset).hour}:${DateTime.parse(
                                                        present[i].clockInTime,
                                                      ).add(DateTime.parse(present[i].clockInTime).timeZoneOffset).minute}:${DateTime.parse(
                                                        present[i].clockInTime,
                                                      ).add(DateTime.parse(present[i].clockInTime).timeZoneOffset).second} ${DateTime.parse(
                                                            present[i]
                                                                .clockInTime,
                                                          ).add(DateTime.parse(present[i].clockInTime).timeZoneOffset).hour < 12 ? "am" : "pm"}",
                                                      style: GoogleFonts.ptSans(
                                                          color:
                                                              GlobalColors.dark,
                                                          fontSize: width < 500
                                                              ? width / 35
                                                              : width / 55),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Divider(),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: width * 0.25,
                                                    child: Text(
                                                      "ClockOut",
                                                      style: GoogleFonts.ptSans(
                                                          color: GlobalColors
                                                              .light,
                                                          fontSize: width < 500
                                                              ? width / 35
                                                              : width / 55),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: width * 0.45,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "${present[i].clockOutTime == null ? "--" : "demo"}",
                                                      style: GoogleFonts.ptSans(
                                                          color:
                                                              GlobalColors.dark,
                                                          fontSize: width < 500
                                                              ? width / 35
                                                              : width / 55),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Divider(),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: width * 0.25,
                                                    child: Text(
                                                      "Late",
                                                      style: GoogleFonts.ptSans(
                                                          color: GlobalColors
                                                              .light,
                                                          fontSize: width < 500
                                                              ? width / 35
                                                              : width / 55),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: width * 0.45,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "${present[i].late == null ? "--" : present[i].late}",
                                                      style: GoogleFonts.ptSans(
                                                          color:
                                                              GlobalColors.dark,
                                                          fontSize: width < 500
                                                              ? width / 35
                                                              : width / 55),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Divider(),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: width * 0.25,
                                                    child: Text(
                                                      "Half Day",
                                                      style: GoogleFonts.ptSans(
                                                          color: GlobalColors
                                                              .light,
                                                          fontSize: width < 500
                                                              ? width / 35
                                                              : width / 55),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: width * 0.45,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "${present[i].halfDay == null ? "--" : present[i].halfDay}",
                                                      style: GoogleFonts.ptSans(
                                                          color:
                                                              GlobalColors.dark,
                                                          fontSize: width < 500
                                                              ? width / 35
                                                              : width / 55),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Divider(),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: width * 0.25,
                                                    child: Text(
                                                      "Working From",
                                                      style: GoogleFonts.ptSans(
                                                          color: GlobalColors
                                                              .light,
                                                          fontSize: width < 500
                                                              ? width / 35
                                                              : width / 55),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: width * 0.45,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "${present[i].workingFrom == null ? "--" : present[i].workingFrom}",
                                                      style: GoogleFonts.ptSans(
                                                          color:
                                                              GlobalColors.dark,
                                                          fontSize: width < 500
                                                              ? width / 35
                                                              : width / 55),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              if (_data[i].leaveDate != null)
                                                Divider(),
                                              if (_data[i].leaveDate != null)
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: width * 0.25,
                                                      child: Text(
                                                        "Leave Date",
                                                        style:
                                                            GoogleFonts.ptSans(
                                                                color:
                                                                    GlobalColors
                                                                        .light,
                                                                fontSize: width <
                                                                        500
                                                                    ? width / 35
                                                                    : width /
                                                                        55),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: width * 0.45,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        "${present[i].leaveDate == null ? "--" : present[i].leaveDate}",
                                                        style:
                                                            GoogleFonts.ptSans(
                                                                color:
                                                                    GlobalColors
                                                                        .dark,
                                                                fontSize: width <
                                                                        500
                                                                    ? width / 35
                                                                    : width /
                                                                        55),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              if (_data[i].leaveDate != null)
                                                Divider(),
                                              if (_data[i].leaveDate != null)
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: width * 0.25,
                                                      child: Text(
                                                        "Leave Reason",
                                                        style:
                                                            GoogleFonts.ptSans(
                                                                color:
                                                                    GlobalColors
                                                                        .light,
                                                                fontSize: width <
                                                                        500
                                                                    ? width / 35
                                                                    : width /
                                                                        55),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: width * 0.45,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        "${present[i].leaveReason == null ? "--" : present[i].leaveReason}",
                                                        style:
                                                            GoogleFonts.ptSans(
                                                                color:
                                                                    GlobalColors
                                                                        .dark,
                                                                fontSize: width <
                                                                        500
                                                                    ? width / 35
                                                                    : width /
                                                                        55),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              if (_data[i].leaveDate != null)
                                                Divider(),
                                              if (_data[i].leaveDate != null)
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: width * 0.25,
                                                      child: Text(
                                                        "Leave Duration",
                                                        style:
                                                            GoogleFonts.ptSans(
                                                                color:
                                                                    GlobalColors
                                                                        .light,
                                                                fontSize: width <
                                                                        500
                                                                    ? width / 35
                                                                    : width /
                                                                        55),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: width * 0.45,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        "${present[i].leaveDuration == null ? "--" : present[i].leaveDuration}",
                                                        style:
                                                            GoogleFonts.ptSans(
                                                                color:
                                                                    GlobalColors
                                                                        .dark,
                                                                fontSize: width <
                                                                        500
                                                                    ? width / 35
                                                                    : width /
                                                                        55),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              if (_data[i].leaveDate != null)
                                                Divider(),
                                              if (_data[i].leaveDate != null)
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: width * 0.25,
                                                      child: Text(
                                                        "Leave Status",
                                                        style:
                                                            GoogleFonts.ptSans(
                                                                color:
                                                                    GlobalColors
                                                                        .light,
                                                                fontSize: width <
                                                                        500
                                                                    ? width / 35
                                                                    : width /
                                                                        55),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: width * 0.45,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        "${present[i].leaveStatus == null ? "--" : present[i].leaveStatus}",
                                                        style:
                                                            GoogleFonts.ptSans(
                                                                color:
                                                                    GlobalColors
                                                                        .dark,
                                                                fontSize: width <
                                                                        500
                                                                    ? width / 35
                                                                    : width /
                                                                        55),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    side: BorderSide(
                                        color:
                                            Color.fromARGB(255, 155, 202, 244),
                                        width: 0.5)),
                                child: Container(
                                  constraints: BoxConstraints(
                                      minHeight: width < 500
                                          ? height * 0.07
                                          : height * 0.09,
                                      minWidth: width),
                                  padding: EdgeInsets.only(bottom: 1),
                                  child: _data[i].holidayDate != null
                                      ? Center(
                                          child: Text(
                                            "HOLIDAY",
                                            style: GoogleFonts.ptSans(
                                                letterSpacing: 4,
                                                color: GlobalColors.dark,
                                                fontSize: width < 500
                                                    ? width / 30
                                                    : width / 55),
                                          ),
                                        )
                                      : Row(
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
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            width * 0.5)),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          width * 0.5),
                                                  child: Image.network(
                                                    present[i].imageUrl!,
                                                    width: width * 0.1,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: width * 0.7,
                                              child: Column(
                                                // mainAxisAlignment:
                                                //     MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 4.0),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          "${present[i].name!}",
                                                          style: GoogleFonts.ptSans(
                                                              color:
                                                                  GlobalColors
                                                                      .dark,
                                                              fontSize: width <
                                                                      500
                                                                  ? width / 30
                                                                  : width / 55),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        width: width * 0.5,
                                                        child: Text(
                                                          "${present[i].designationName}",
                                                          style: GoogleFonts.ptSans(
                                                              color:
                                                                  GlobalColors
                                                                      .light,
                                                              fontSize: width <
                                                                      500
                                                                  ? width / 40
                                                                  : width / 55),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 4.0,
                                                            bottom: 4),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: 8,
                                                          height: 8,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 4),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        width *
                                                                            0.5),
                                                            color: GlobalColors
                                                                .green,
                                                          ),
                                                        ),
                                                        Text(
                                                          "Present",
                                                          style: GoogleFonts.ptSans(
                                                              color:
                                                                  GlobalColors
                                                                      .dark,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800,
                                                              fontSize: width <
                                                                      500
                                                                  ? width / 40
                                                                  : width / 55),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 15.0),
                                                          child: Text(
                                                            "${DateTime.parse(
                                                              present[i]
                                                                  .clockInTime,
                                                            ).add(DateTime.parse(present[i].clockInTime).timeZoneOffset).hour}:${DateTime.parse(
                                                              present[i]
                                                                  .clockInTime,
                                                            ).add(DateTime.parse(present[i].clockInTime).timeZoneOffset).minute}:${DateTime.parse(
                                                              present[i]
                                                                  .clockInTime,
                                                            ).add(DateTime.parse(present[i].clockInTime).timeZoneOffset).second} ${DateTime.parse(
                                                                  present[i]
                                                                      .clockInTime,
                                                                ).add(DateTime.parse(present[i].clockInTime).timeZoneOffset).hour < 12 ? "am" : "pm"}",
                                                            style: GoogleFonts.ptSans(
                                                                color:
                                                                    GlobalColors
                                                                        .light,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: width <
                                                                        500
                                                                    ? width / 40
                                                                    : width /
                                                                        55),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                ),
                              ),
                            ),
                      if (attendanceAction == "Absent")
                        for (var i = 0; i < absent.length; i++)
                          if (absent[i].name != "Richard C" &&
                              absent[i].name != "Robinson")
                            InkWell(
                              onTap: () {
                                showDialog<void>(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              child: Image.network(
                                                absent[i].imageUrl!,
                                                width: width < 500
                                                    ? width / 8
                                                    : width / 45,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5.0),
                                              child: Text(
                                                "${absent[i].name}",
                                                style: GoogleFonts.ptSans(
                                                    color: GlobalColors.light,
                                                    fontSize: width < 500
                                                        ? width / 28
                                                        : width / 55),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Row(
                                              children: [
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
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: width < 500
                                                          ? width / 40
                                                          : width / 55),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      content: Container(
                                        width: width,
                                        constraints: BoxConstraints(
                                            minHeight: height * 0.2,
                                            minWidth: width),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Divider(),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: width * 0.25,
                                                    child: Text(
                                                      "ClockIn",
                                                      style: GoogleFonts.ptSans(
                                                          color: GlobalColors
                                                              .light,
                                                          fontSize: width < 500
                                                              ? width / 35
                                                              : width / 55),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: width * 0.45,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "${absent[i].clockInTime}",
                                                      style: GoogleFonts.ptSans(
                                                          color:
                                                              GlobalColors.dark,
                                                          fontSize: width < 500
                                                              ? width / 35
                                                              : width / 55),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Divider(),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: width * 0.25,
                                                    child: Text(
                                                      "ClockOut",
                                                      style: GoogleFonts.ptSans(
                                                          color: GlobalColors
                                                              .light,
                                                          fontSize: width < 500
                                                              ? width / 35
                                                              : width / 55),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: width * 0.45,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "${absent[i].clockOutTime}",
                                                      style: GoogleFonts.ptSans(
                                                          color:
                                                              GlobalColors.dark,
                                                          fontSize: width < 500
                                                              ? width / 35
                                                              : width / 55),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Divider(),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: width * 0.25,
                                                    child: Text(
                                                      "Late",
                                                      style: GoogleFonts.ptSans(
                                                          color: GlobalColors
                                                              .light,
                                                          fontSize: width < 500
                                                              ? width / 35
                                                              : width / 55),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: width * 0.45,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "${absent[i].late == null ? "--" : absent[i].late}",
                                                      style: GoogleFonts.ptSans(
                                                          color:
                                                              GlobalColors.dark,
                                                          fontSize: width < 500
                                                              ? width / 35
                                                              : width / 55),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Divider(),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: width * 0.25,
                                                    child: Text(
                                                      "Half Day",
                                                      style: GoogleFonts.ptSans(
                                                          color: GlobalColors
                                                              .light,
                                                          fontSize: width < 500
                                                              ? width / 35
                                                              : width / 55),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: width * 0.45,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "${absent[i].halfDay == null ? "--" : absent[i].halfDay}",
                                                      style: GoogleFonts.ptSans(
                                                          color:
                                                              GlobalColors.dark,
                                                          fontSize: width < 500
                                                              ? width / 35
                                                              : width / 55),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Divider(),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: width * 0.25,
                                                    child: Text(
                                                      "Working From",
                                                      style: GoogleFonts.ptSans(
                                                          color: GlobalColors
                                                              .light,
                                                          fontSize: width < 500
                                                              ? width / 35
                                                              : width / 55),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: width * 0.45,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "${absent[i].workingFrom == null ? "--" : absent[i].workingFrom}",
                                                      style: GoogleFonts.ptSans(
                                                          color:
                                                              GlobalColors.dark,
                                                          fontSize: width < 500
                                                              ? width / 35
                                                              : width / 55),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              if (absent[i].clockInTime == null)
                                                Divider(),
                                              if (absent[i].clockInTime == null)
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: width * 0.25,
                                                      child: Text(
                                                        "Leave Date",
                                                        style:
                                                            GoogleFonts.ptSans(
                                                                color:
                                                                    GlobalColors
                                                                        .light,
                                                                fontSize: width <
                                                                        500
                                                                    ? width / 35
                                                                    : width /
                                                                        55),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: width * 0.45,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        "${absent[i].leaveDate == null ? "--" : absent[i].leaveDate}",
                                                        style:
                                                            GoogleFonts.ptSans(
                                                                color:
                                                                    GlobalColors
                                                                        .dark,
                                                                fontSize: width <
                                                                        500
                                                                    ? width / 35
                                                                    : width /
                                                                        55),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              if (absent[i].clockInTime == null)
                                                Divider(),
                                              if (absent[i].clockInTime == null)
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: width * 0.25,
                                                      child: Text(
                                                        "Leave Reason",
                                                        style:
                                                            GoogleFonts.ptSans(
                                                                color:
                                                                    GlobalColors
                                                                        .light,
                                                                fontSize: width <
                                                                        500
                                                                    ? width / 35
                                                                    : width /
                                                                        55),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: width * 0.45,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        "${absent[i].leaveReason == null ? "--" : absent[i].leaveReason}",
                                                        style:
                                                            GoogleFonts.ptSans(
                                                                color:
                                                                    GlobalColors
                                                                        .dark,
                                                                fontSize: width <
                                                                        500
                                                                    ? width / 35
                                                                    : width /
                                                                        55),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              if (absent[i].clockInTime == null)
                                                Divider(),
                                              if (absent[i].clockInTime == null)
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: width * 0.25,
                                                      child: Text(
                                                        "Leave Duration",
                                                        style:
                                                            GoogleFonts.ptSans(
                                                                color:
                                                                    GlobalColors
                                                                        .light,
                                                                fontSize: width <
                                                                        500
                                                                    ? width / 35
                                                                    : width /
                                                                        55),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: width * 0.45,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        "${absent[i].leaveDuration == null ? "--" : absent[i].leaveDuration}",
                                                        style:
                                                            GoogleFonts.ptSans(
                                                                color:
                                                                    GlobalColors
                                                                        .dark,
                                                                fontSize: width <
                                                                        500
                                                                    ? width / 35
                                                                    : width /
                                                                        55),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              if (absent[i].clockInTime == null)
                                                Divider(),
                                              if (absent[i].clockInTime == null)
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: width * 0.25,
                                                      child: Text(
                                                        "Leave Status",
                                                        style:
                                                            GoogleFonts.ptSans(
                                                                color:
                                                                    GlobalColors
                                                                        .light,
                                                                fontSize: width <
                                                                        500
                                                                    ? width / 35
                                                                    : width /
                                                                        55),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: width * 0.45,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        "${absent[i].leaveStatus == null ? "--" : absent[i].leaveStatus}",
                                                        style:
                                                            GoogleFonts.ptSans(
                                                                color:
                                                                    GlobalColors
                                                                        .dark,
                                                                fontSize: width <
                                                                        500
                                                                    ? width / 35
                                                                    : width /
                                                                        55),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    side: BorderSide(
                                        color:
                                            Color.fromARGB(255, 155, 202, 244),
                                        width: 0.5)),
                                child: Container(
                                  constraints: BoxConstraints(
                                      minHeight: width < 500
                                          ? height * 0.07
                                          : height * 0.09,
                                      minWidth: width),
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
                                              borderRadius:
                                                  BorderRadius.circular(
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
                                        width: width * 0.7,
                                        child: Column(
                                          // mainAxisAlignment:
                                          //     MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 4.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "${absent[i].name!}",
                                                    style: GoogleFonts.ptSans(
                                                        color:
                                                            GlobalColors.dark,
                                                        fontSize: width < 500
                                                            ? width / 30
                                                            : width / 55),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: width * 0.5,
                                                  child: Text(
                                                    "${absent[i].designationName}",
                                                    style: GoogleFonts.ptSans(
                                                        color:
                                                            GlobalColors.light,
                                                        fontSize: width < 500
                                                            ? width / 40
                                                            : width / 55),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 4.0, bottom: 4),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 8,
                                                    height: 8,
                                                    margin: EdgeInsets.only(
                                                        right: 4),
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
                                                        color:
                                                            GlobalColors.dark,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        fontSize: width < 500
                                                            ? width / 40
                                                            : width / 55),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15.0),
                                                    child: Text(
                                                      "${absent[i].leaveReason ?? "--"}",
                                                      style: GoogleFonts.ptSans(
                                                          color: GlobalColors
                                                              .light,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: width < 500
                                                              ? width / 40
                                                              : width / 55),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
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
              }))
            ],
          ),
        ),
      ),
    );
  }
}
