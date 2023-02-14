// ignore_for_file: library_private_types_in_public_api

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:w3cert/const/const.dart';
import 'package:w3cert/provider/providers.dart';
import 'package:w3cert/screens/task/widgets/task-add.dart';
import 'package:w3cert/screens/task/widgets/task-detail.dart';

import '../../router/routing-const.dart';
import '../../widgets/custom-drawer.dart';

class Tasks extends ConsumerStatefulWidget {
  const Tasks({Key? key}) : super(key: key);

  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends ConsumerState<Tasks> {
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a ke

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final data = ref.watch(taskProvider);

    reftesh() async {
      return Future<void>.delayed(const Duration(microseconds: 1), () {
        return ref.refresh(taskProvider);
      });
    }

    return SafeArea(
      child: Scaffold(
        key: _key,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet<void>(
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: height * 0.7,
                  child: AddTask(
                    onClick: reftesh,
                  ),
                );
              },
            );
          },
          child: Icon(Icons.add), // <-- Opens drawer
        ),
        appBar: AppBar(
          title: InkWell(
            onTap: reftesh,
            child: Text(
              "Tasks",
              style: GoogleFonts.josefinSans(
                  color: GlobalColors.white,
                  fontSize: width < 500 ? width / 25 : width / 35),
            ),
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
            return SingleChildScrollView(
              child: Column(
                children: [
                  for (var i = 0; i < _data.length; i++)
                    InkWell(
                      onTap: () {
                        ref.watch(taskIdProvider.notifier).update(
                              (state) => _data[i].id!,
                            );
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => Container(
                                width: width,
                                height: height,
                                child: TaskDetail()));
                      },
                      child: Card(
                        elevation: 10,
                        child: Container(
                          width: width * 0.95,
                          height: height * 0.13,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: width * 0.45,
                                    child: Wrap(
                                      children: [
                                        Text(
                                          "${_data[i].heading}",
                                          style: GoogleFonts.josefinSans(
                                              color: GlobalColors.dark,
                                              fontSize: width < 500
                                                  ? width / 35
                                                  : width / 35),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: width * 0.1,
                                    child: Wrap(
                                      children: [
                                        Text(
                                          "#${_data[i].id}",
                                          style: GoogleFonts.josefinSans(
                                              color: GlobalColors.blue,
                                              fontSize: width < 500
                                                  ? width / 35
                                                  : width / 35),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: width * 0.25,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Icon(Icons.calendar_today,
                                            color: GlobalColors.light,
                                            size: width < 500
                                                ? width / 35
                                                : width / 35),
                                        Text(
                                          "${_data[i].createOn}24-02-2023",
                                          style: GoogleFonts.josefinSans(
                                              color: GlobalColors.light,
                                              fontSize: width < 500
                                                  ? width / 35
                                                  : width / 35),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: width * 0.6,
                                    child: Row(
                                      children: [
                                        if (_data[i].projectName != null)
                                          Icon(Icons.layers,
                                              color: GlobalColors.light,
                                              size: width < 500
                                                  ? width / 35
                                                  : width / 35),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 4.0),
                                          child: Text(
                                            "${_data[i].projectName ?? "--"}",
                                            style: GoogleFonts.josefinSans(
                                                color: GlobalColors.light,
                                                fontSize: width < 500
                                                    ? width / 38
                                                    : width / 35),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: width * 0.2,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: _data[i].boardColumn!.slug ==
                                              "incomplete"
                                          ? Color.fromARGB(255, 255, 223, 221)
                                          : Color.fromARGB(255, 219, 255, 220),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 2),
                                    child: Wrap(
                                      children: [
                                        Text(
                                          "${_data[i].boardColumn!.slug}",
                                          style: GoogleFonts.josefinSans(
                                              color:
                                                  _data[i].boardColumn!.slug ==
                                                          "incomplete"
                                                      ? GlobalColors.red
                                                      : GlobalColors.green,
                                              fontSize: width < 500
                                                  ? width / 40
                                                  : width / 35),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 213, 231, 245),
                                        borderRadius:
                                            BorderRadius.circular(width * 0.5)),
                                    child: Container(
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: Image.network(
                                              _data[i].users![0].imageUrl!,
                                              width: width < 500
                                                  ? width / 22
                                                  : width / 35,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            child: Text(
                                              "${_data[i].users![0].name}",
                                              style: GoogleFonts.josefinSans(
                                                  color: GlobalColors.blue,
                                                  fontSize: width < 500
                                                      ? width / 45
                                                      : width / 35),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  if (_data[i].dueOn!.isNotEmpty)
                                    Container(
                                      width: width * 0.4,
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 2),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            child: Text(
                                              "Due On :",
                                              style: GoogleFonts.josefinSans(
                                                  color: GlobalColors.dark,
                                                  fontSize: width < 500
                                                      ? width / 35
                                                      : width / 35),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "${_data[i].dueOn}",
                                                  style:
                                                      GoogleFonts.josefinSans(
                                                          color:
                                                              GlobalColors.dark,
                                                          fontSize: width < 500
                                                              ? width / 35
                                                              : width / 35),
                                                ),
                                                if (DateFormat("dd-MM-yyyy")
                                                    .parse(_data[i].dueOn!)
                                                    .isBefore(
                                                        DateTime.now().toUtc()))
                                                  Text(
                                                    "(over due)",
                                                    style:
                                                        GoogleFonts.josefinSans(
                                                            color: GlobalColors
                                                                .red,
                                                            fontSize: width <
                                                                    500
                                                                ? width / 35
                                                                : width / 35),
                                                  ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 8,
                                            height: 8,
                                            margin: EdgeInsets.only(right: 4),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      width * 0.5),
                                              color: DateFormat("dd-MM-yyyy")
                                                      .parse(_data[i].dueOn!)
                                                      .isBefore(DateTime.now()
                                                          .toUtc())
                                                  ? Color.fromARGB(
                                                      255, 238, 7, 7)
                                                  : Color.fromARGB(
                                                      255, 5, 163, 21),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
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
          }),
        ),
      ),
    );
  }
}
