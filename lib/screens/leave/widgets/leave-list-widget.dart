import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:w3cert/provider/providers.dart';

import '../../../api/api.dart';
import '../../../const/const.dart';
import '../../../models/leaveModel.dart';

enum SampleItem { pending, approved, rejected }

class LeaveListWidget extends ConsumerStatefulWidget {
  final LeaveModel leave;
  final Function onClick;
  const LeaveListWidget({
    Key? key,
    required this.leave,
    required this.onClick,
  }) : super(key: key);

  @override
  _LeaveListWidgetState createState() => _LeaveListWidgetState();
}

class _LeaveListWidgetState extends ConsumerState<LeaveListWidget> {
  SampleItem action = SampleItem.approved;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final data = ref.watch(employeProvider);
    final token = ref.watch(tokenProvider);

    return Container(
      child: data.when(data: (_data) {
        return SingleChildScrollView(
          child: Column(
            children: [
              for (var i = 0; i < _data.length; i++)
                if (_data[i].id == widget.leave.userId)
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
                            width: width < 500 ? width * 0.1 : width * 0.07,
                            margin:
                                EdgeInsets.symmetric(horizontal: width * 0.02),
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
                                  width:
                                      width < 500 ? width * 0.1 : width * 0.05,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: width * 0.6,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: width * 0.2,
                                      child: Text(
                                        "${widget.leave.type!.typeName!}",
                                        style: GoogleFonts.ptSans(
                                            color: GlobalColors.dark,
                                            fontSize: width < 500
                                                ? width / 35
                                                : width / 55),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      width: width * 0.4,
                                      child: Container(
                                        width: width * 0.25,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Icon(Icons.calendar_view_week_sharp,
                                                color: GlobalColors.dark,
                                                size: width < 500
                                                    ? width / 35
                                                    : width / 55),
                                            Text(
                                              " ${DateFormat("dd-MM-yyy").format(widget.leave.leaveDate!)}",
                                              style: GoogleFonts.ptSans(
                                                  color: GlobalColors.light,
                                                  fontSize: width < 500
                                                      ? width / 35
                                                      : width / 55),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: width * 0.4,
                                      child: Text(
                                        "${widget.leave.reason}",
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
                                        borderRadius:
                                            BorderRadius.circular(width * 0.5),
                                        color: widget.leave.status == "pending"
                                            ? GlobalColors.orange
                                            : widget.leave.status == "approved"
                                                ? GlobalColors.green
                                                : GlobalColors.red,
                                      ),
                                    ),
                                    Text(
                                      "${widget.leave.status}",
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
                            alignment: Alignment.center,
                            child: PopupMenuButton<SampleItem>(
                              initialValue: action,
                              // Callback that sets the selected popup menu item.
                              onSelected: (SampleItem item) {
                                setState(() {
                                  action = item;
                                });
                                Api()
                                    .leaveUpdate(
                                        token, widget.leave.id!, action.name)
                                    .then((value) {
                                  if (value.statusCode == 200) {
                                    customAlert(context, width, height, true,
                                        "${value.data["message"]}");
                                    return widget.onClick();
                                  }
                                  customAlert(context, width, height, false,
                                      "Something went wrong , Please try again");
                                });
                              },
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry<SampleItem>>[
                                PopupMenuItem<SampleItem>(
                                  value: SampleItem.approved,
                                  child: Text(
                                    "approved",
                                    style: GoogleFonts.ptSans(
                                        color: GlobalColors.green,
                                        fontSize: width < 500
                                            ? width / 35
                                            : width / 55),
                                  ),
                                ),
                                PopupMenuItem<SampleItem>(
                                  value: SampleItem.pending,
                                  child: Text(
                                    'pending',
                                    style: GoogleFonts.ptSans(
                                        color: GlobalColors.orange,
                                        fontSize: width < 500
                                            ? width / 35
                                            : width / 55),
                                  ),
                                ),
                                PopupMenuItem<SampleItem>(
                                  value: SampleItem.rejected,
                                  child: Text(
                                    'rejected',
                                    style: GoogleFonts.ptSans(
                                        color: GlobalColors.red,
                                        fontSize: width < 500
                                            ? width / 35
                                            : width / 55),
                                  ),
                                ),
                              ],
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
        return Center(
            child: CircularProgressIndicator.adaptive(
          strokeWidth: 2,
        ));
      }),
    );
  }
}
