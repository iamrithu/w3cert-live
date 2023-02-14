import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:w3cert/models/userModel.dart';
import 'package:w3cert/provider/providers.dart';

import '../const/const.dart';
import '../router/routing-const.dart';
import 'custom-listview.dart';

class CustomDrawer extends ConsumerStatefulWidget {
  final double width;
  final double height;

  const CustomDrawer({Key? key, required this.width, required this.height})
      : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends ConsumerState<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: Column(
        children: [
          Container(
            width: widget.width,
            height: widget.height * 0.11,
            color: GlobalColors.themeColor,
            alignment: Alignment.center,
            child: Consumer(builder: (context, ref, child) {
              final user = ref.watch(userDataProvider);

              return user.when(data: (_value) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(1000),
                        child: Image.network(_value.user!.imageUrl!),
                      ),
                    ),
                    Container(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '${_value.user!.name}',
                              style: GoogleFonts.josefinSans(
                                color: GlobalColors.white,
                                fontSize: widget.width < 500
                                    ? widget.width / 30
                                    : widget.width / 40,
                              ),
                            ),
                            Text(
                              '${_value.user!.employeeDetail!.designation.name}',
                              style: GoogleFonts.josefinSans(
                                color: GlobalColors.white,
                                fontSize: widget.width < 500
                                    ? widget.width / 35
                                    : widget.width / 45,
                              ),
                            ),
                          ]),
                    )
                  ],
                );
              }, error: (error, stackTrace) {
                return Text(error.toString());
              }, loading: () {
                return CircularProgressIndicator.adaptive();
              });
            }),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    context.pushNamed(
                      RoutingConstants.dashboard,
                    );
                  },
                  child: CustomListview(
                    width: widget.width,
                    height: widget.height,
                    asset: "Assets/layout.png",
                    content: "Dashboard",
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);

                    context.pushNamed(RoutingConstants.employee);
                  },
                  child: CustomListview(
                    width: widget.width,
                    height: widget.height,
                    asset: "Assets/recruitment.png",
                    content: "Employee",
                  ),
                ),
                CustomListview(
                  width: widget.width,
                  height: widget.height,
                  asset: "Assets/project.png",
                  content: "Projects",
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);

                    context.pushNamed(RoutingConstants.task);
                  },
                  child: CustomListview(
                    width: widget.width,
                    height: widget.height,
                    asset: "Assets/tasks.png",
                    content: "Tasks",
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);

                    if (DateFormat("dd-MM-yyyy").format(DateTime.now()) !=
                        ref.watch(attendenceDate)) {
                      ref.watch(attendenceDate.notifier).update((state) =>
                          "${DateFormat("dd-MM-yyyy").format(DateTime.now())}");
                    }
                    context.pushNamed(RoutingConstants.attendence);
                  },
                  child: CustomListview(
                    width: widget.width,
                    height: widget.height,
                    asset: "Assets/attendence.png",
                    content: "Attendence",
                  ),
                ),
                CustomListview(
                  width: widget.width,
                  height: widget.height,
                  asset: "Assets/bill.png",
                  content: "Invoices",
                ),
                CustomListview(
                  width: widget.width,
                  height: widget.height,
                  asset: "Assets/leave.png",
                  content: "Leaves",
                ),
                CustomListview(
                  width: widget.width,
                  height: widget.height,
                  asset: "Assets/expenses.png",
                  content: "Expenses",
                ),
                CustomListview(
                  width: widget.width,
                  height: widget.height,
                  asset: "Assets/ticket.png",
                  content: "Tickets",
                ),
                CustomListview(
                  width: widget.width,
                  height: widget.height,
                  asset: "Assets/info.png",
                  content: "About",
                ),
                InkWell(
                  onTap: () async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setBool('repeat', false);
                    await prefs.setString('email', "");
                    await prefs.setString('password', "");
                    ref
                        .watch(loggedInProvider.notifier)
                        .update((state) => false);
                  },
                  child: CustomListview(
                    width: widget.width,
                    height: widget.height,
                    asset: "Assets/logout.png",
                    content: "Logout",
                  ),
                ),
                // Container(
                //     width: widget.width,
                //     height: widget.height * 0.1,
                //     alignment: Alignment.center,
                //     child: Image.asset(
                //       "Assets/icon.jpg",
                //     ))
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
