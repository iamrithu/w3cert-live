import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:w3cert/provider/providers.dart';

import '../../../const/const.dart';

enum SampleItem { completed, incomplete }

class TaskDetail extends ConsumerStatefulWidget {
  const TaskDetail({Key? key}) : super(key: key);

  @override
  _TaskDetailState createState() => _TaskDetailState();
}

class _TaskDetailState extends ConsumerState<TaskDetail> {
  SampleItem action = SampleItem.completed;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final data = ref.watch(singleTaskProvider);
    final employee = ref.watch(employeProvider);

    return AlertDialog(
      title: Text(
        'Task Details',
        style: GoogleFonts.ptSans(
            color: GlobalColors.dark,
            fontSize: width < 500 ? width / 25 : width / 35),
      ),
      content: Container(
        width: width < 500 ? width : width * 0.6,
        height: height * 0.5,
        child: data.when(
          data: (_data) {
            return Column(
              children: [
                Container(
                  width: width,
                  height: height * 0.05,
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(
                        color: Color.fromARGB(255, 173, 171, 171), width: 0.5),
                  )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: width * 0.15,
                        child: Text(
                          "Project",
                          style: GoogleFonts.ptSans(
                              color: GlobalColors.light,
                              fontSize: width < 500 ? width / 35 : width / 55),
                        ),
                      ),
                      Container(
                        width: width * 0.05,
                        child: Icon(
                          Icons.layers,
                          size: width < 500 ? width / 28 : width / 55,
                          color: GlobalColors.light,
                        ),
                      ),
                      Container(
                        width: width * 0.4,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "${_data.project == null ? "--" : _data.project!.projectName}",
                          style: GoogleFonts.ptSans(
                              color: GlobalColors.dark,
                              fontSize: width < 500 ? width / 35 : width / 55),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: width,
                  height: height * 0.05,
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(
                        color: Color.fromARGB(255, 173, 171, 171), width: 0.5),
                  )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: width * 0.2,
                        child: Text(
                          "title",
                          style: GoogleFonts.ptSans(
                              color: GlobalColors.light,
                              fontSize: width < 500 ? width / 35 : width / 55),
                        ),
                      ),
                      Container(
                        width: width * 0.4,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "${_data.heading == null ? "--" : _data.heading}",
                          style: GoogleFonts.ptSans(
                              color: GlobalColors.dark,
                              fontSize: width < 500 ? width / 35 : width / 55),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: width,
                  height: height * 0.05,
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(
                        color: Color.fromARGB(255, 173, 171, 171), width: 0.5),
                  )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: width * 0.2,
                        child: Text(
                          "Assigned By",
                          style: GoogleFonts.ptSans(
                              color: GlobalColors.light,
                              fontSize: width < 500 ? width / 35 : width / 55),
                        ),
                      ),
                      employee.when(data: (_user) {
                        return Container(
                            width: width * 0.4,
                            alignment: Alignment.centerLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                for (var u = 0; u < _user.length; u++)
                                  if (_user[u].id == _data.addedBy)
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.all(2),
                                      margin: EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 245, 237, 237),
                                          borderRadius: BorderRadius.circular(
                                              width * 0.5)),
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              child: Image.network(
                                                _user[u].imageUrl!,
                                                width: width < 500
                                                    ? width / 22
                                                    : width / 45,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5.0),
                                              child: Text(
                                                "${_user[u].name}",
                                                style: GoogleFonts.ptSans(
                                                    color: GlobalColors.light,
                                                    fontSize: width < 500
                                                        ? width / 40
                                                        : width / 55),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                              ],
                            ));
                      }, error: (e, s) {
                        return Center(child: Text(e.toString()));
                      }, loading: () {
                        return Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      }),
                    ],
                  ),
                ),
                Container(
                  constraints:
                      BoxConstraints(minHeight: height * 0.05, minWidth: width),
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(
                        color: Color.fromARGB(255, 252, 231, 231), width: 0.5),
                  )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: width * 0.2,
                        child: Text(
                          "Assigned to",
                          style: GoogleFonts.ptSans(
                              color: GlobalColors.light,
                              fontSize: width < 500 ? width / 35 : width / 55),
                        ),
                      ),
                      employee.when(data: (_user) {
                        return Container(
                            width: width * 0.4,
                            alignment: Alignment.centerLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                for (var u = 0; u < _user.length; u++)
                                  for (var j = 0; j < _data.users!.length; j++)
                                    if (_user[u].id == _data.users![j].id)
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        padding: EdgeInsets.all(2),
                                        margin: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 227, 241, 253),
                                            borderRadius: BorderRadius.circular(
                                                width * 0.5)),
                                        child: Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                child: Image.network(
                                                  _user[u].imageUrl!,
                                                  width: width < 500
                                                      ? width / 22
                                                      : width / 45,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5.0),
                                                child: Text(
                                                  "${_user[u].name}",
                                                  style: GoogleFonts.ptSans(
                                                      color: GlobalColors.blue,
                                                      fontSize: width < 500
                                                          ? width / 40
                                                          : width / 55),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                              ],
                            ));
                      }, error: (e, s) {
                        return Center(child: Text(e.toString()));
                      }, loading: () {
                        return Center(
                          child: CircularProgressIndicator.adaptive(),
                        );
                      }),
                    ],
                  ),
                ),
                Container(
                  width: width,
                  height: height * 0.05,
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(
                        color: Color.fromARGB(255, 173, 171, 171), width: 0.5),
                  )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: width * 0.2,
                        child: Text(
                          "Priority",
                          style: GoogleFonts.ptSans(
                              color: GlobalColors.light,
                              fontSize: width < 500 ? width / 35 : width / 55),
                        ),
                      ),
                      Container(
                        width: width * 0.4,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "${_data.priority == null ? "--" : _data.priority}",
                          style: GoogleFonts.ptSans(
                              color: GlobalColors.dark,
                              fontSize: width < 500 ? width / 35 : width / 55),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: width,
                  height: height * 0.05,
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(
                        color: Color.fromARGB(255, 173, 171, 171), width: 0.5),
                  )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: width * 0.2,
                        child: Text(
                          "Status",
                          style: GoogleFonts.ptSans(
                              color: GlobalColors.light,
                              fontSize: width < 500 ? width / 35 : width / 55),
                        ),
                      ),
                      Container(
                        width: width * 0.4,
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Text(
                              "${_data.status == null ? "--" : _data.status}",
                              style: GoogleFonts.ptSans(
                                  color: _data.status == "incomplete"
                                      ? GlobalColors.red
                                      : GlobalColors.green,
                                  fontSize:
                                      width < 500 ? width / 35 : width / 55),
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
                                  Navigator.pop(context);

                                  customAlert(context, width, height, false,
                                      "Something went wrong , Please try again");
                                },
                                itemBuilder: (BuildContext context) =>
                                    <PopupMenuEntry<SampleItem>>[
                                  PopupMenuItem<SampleItem>(
                                    value: SampleItem.completed,
                                    child: Text(
                                      "Completed",
                                      style: GoogleFonts.ptSans(
                                          color: GlobalColors.green,
                                          fontSize: width < 500
                                              ? width / 35
                                              : width / 55),
                                    ),
                                  ),
                                  PopupMenuItem<SampleItem>(
                                    value: SampleItem.completed,
                                    child: Text(
                                      'Incomplete',
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
                    ],
                  ),
                ),
                Container(
                  width: width,
                  height: height * 0.05,
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(
                        color: Color.fromARGB(255, 173, 171, 171), width: 0.5),
                  )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: width * 0.15,
                        child: Text(
                          "Start Date",
                          style: GoogleFonts.ptSans(
                              color: GlobalColors.light,
                              fontSize: width < 500 ? width / 35 : width / 55),
                        ),
                      ),
                      Container(
                        width: width * 0.05,
                        child: Icon(
                          Icons.calendar_month,
                          size: width < 500 ? width / 28 : width / 55,
                          color: GlobalColors.light,
                        ),
                      ),
                      Container(
                        width: width * 0.4,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "${_data.createOn == null ? "--" : _data.createOn}",
                          style: GoogleFonts.ptSans(
                              color: GlobalColors.dark,
                              fontSize: width < 500 ? width / 35 : width / 55),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: width,
                  height: height * 0.05,
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(
                        color: Color.fromARGB(255, 173, 171, 171), width: 0.5),
                  )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: width * 0.15,
                        child: Text(
                          "End Date",
                          style: GoogleFonts.ptSans(
                              color: GlobalColors.light,
                              fontSize: width < 500 ? width / 35 : width / 55),
                        ),
                      ),
                      Container(
                        width: width * 0.05,
                        child: Icon(
                          Icons.calendar_month,
                          size: width < 500 ? width / 28 : width / 55,
                          color: GlobalColors.light,
                        ),
                      ),
                      Container(
                        width: width * 0.4,
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Text(
                              "${_data.dueOn == null ? "--" : _data.dueOn!}",
                              style: GoogleFonts.ptSans(
                                  color: GlobalColors.dark,
                                  fontSize:
                                      width < 500 ? width / 35 : width / 55),
                            ),
                            if (_data.dueOn!.isNotEmpty)
                              Container(
                                width: 8,
                                height: 8,
                                margin: EdgeInsets.only(left: 5, right: 4),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(width * 0.5),
                                  color: DateFormat("dd-MM-yyyy")
                                          .parse(_data.dueOn!)
                                          .isBefore(DateTime.now().toUtc())
                                      ? Color.fromARGB(255, 238, 7, 7)
                                      : Color.fromARGB(255, 5, 163, 21),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (_data.dueOn!.isNotEmpty)
                  if (DateFormat("dd-MM-yyyy")
                      .parse(_data.dueOn!)
                      .isBefore(DateTime.now().toUtc()))
                    Container(
                      width: width,
                      height: height * 0.05,
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                            color: Color.fromARGB(255, 173, 171, 171),
                            width: 0.5),
                      )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: width * 0.2,
                            child: Text(
                              "Over Due",
                              style: GoogleFonts.ptSans(
                                  color: GlobalColors.light,
                                  fontSize:
                                      width < 500 ? width / 35 : width / 55),
                            ),
                          ),
                          Container(
                            width: width * 0.4,
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Text(
                                  "true",
                                  style: GoogleFonts.ptSans(
                                      color: GlobalColors.red,
                                      fontSize: width < 500
                                          ? width / 35
                                          : width / 55),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
              ],
            );
          },
          error: (e, s) {
            return Text("${e}");
          },
          loading: () {
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          },
        ),

        // actions: <Widget>[
        //   TextButton(
        //     onPressed: () => Navigator.pop(context, 'Cancel'),
        //     child: const Text('Cancel'),
        //   ),
        //   TextButton(
        //     onPressed: () => Navigator.pop(context, 'OK'),
        //     child: const Text('OK'),
        //   ),
        // ],
      ),
    );
  }
}
