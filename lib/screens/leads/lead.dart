// ignore_for_file: library_private_types_in_public_api

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:w3cert/const/const.dart';
import 'package:w3cert/models/leadModel.dart';
import 'package:w3cert/provider/providers.dart';
import 'package:w3cert/screens/leads/widgets/lead-list.dart';
import 'package:w3cert/screens/task/widgets/task-add.dart';
import 'package:w3cert/screens/task/widgets/task-detail.dart';

import '../../router/routing-const.dart';
import '../../widgets/custom-drawer.dart';

class Leads extends ConsumerStatefulWidget {
  const Leads({Key? key}) : super(key: key);

  @override
  _LeadsState createState() => _LeadsState();
}

class _LeadsState extends ConsumerState<Leads> {
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a ke

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final data = ref.watch(leadProvider);

    reftesh() async {
      return Future<void>.delayed(const Duration(microseconds: 1), () {
        return ref.refresh(leadProvider);
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
              "Leads",
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
            List<LeadModel> lead = _data;
            return LeadsList(lead: lead);
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
