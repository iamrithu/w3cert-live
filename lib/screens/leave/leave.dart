// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:w3cert/const/const.dart';
import 'package:w3cert/provider/providers.dart';
import 'package:w3cert/screens/leave/widgets/leave-list-widget.dart';
import '../../router/routing-const.dart';
import '../../widgets/custom-drawer.dart';

class Leave extends ConsumerStatefulWidget {
  const Leave({Key? key}) : super(key: key);

  @override
  _LeaveState createState() => _LeaveState();
}

class _LeaveState extends ConsumerState<Leave> {
  reftesh() async {
    return Future<void>.delayed(const Duration(microseconds: 1), () {
      return ref.refresh(leaveProvider);
    });
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a ke

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final data = ref.watch(leaveProvider);

    return SafeArea(
      child: Scaffold(
        key: _key,
        appBar: AppBar(
          title: InkWell(
            onTap: () {},
            child: Text(
              "Leave",
              style: GoogleFonts.ptSans(
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
                    LeaveListWidget(
                      onClick: reftesh,
                      leave: _data[i],
                    )
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
