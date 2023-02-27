import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:w3cert/models/employeeModel.dart';

import '../../../const/const.dart';
import '../../../provider/providers.dart';

class MultiSelectParticipant extends ConsumerStatefulWidget {
  final List<Map<String, dynamic>> selectedMember;
  final List<EmployeeModel> getemployeeList;
  final Function onClick;

  MultiSelectParticipant({
    Key? key,
    required this.onClick,
    required this.selectedMember,
    required this.getemployeeList,
  }) : super(key: key);

  @override
  _MultiSelectParticipantState createState() => _MultiSelectParticipantState();
}

class _MultiSelectParticipantState
    extends ConsumerState<MultiSelectParticipant> {
  List<String?> members = [];
  List<EmployeeModel> employeeList = [];

  @override
  void initState() {
    employeeList = widget.getemployeeList;
    if (widget.selectedMember.isNotEmpty) {
      widget.selectedMember.forEach((element) {
        setState(() {
          members.add(element["image"]);
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
        width: width,

        // height: height * 0.8,
        child: AlertDialog(
          title: Text(
            "Members ${widget.selectedMember.length}",
            style: GoogleFonts.josefinSans(
                color: GlobalColors.themeColor,
                fontSize: width < 500 ? width / 25 : width / 35),
          ),
          content: Container(
              height: height,
              width: width,
              child: Column(
                children: [
                  if (widget.selectedMember.isNotEmpty)
                    Container(
                      height: height * 0.06,
                      width: width,
                      child: Row(
                        children: [
                          for (var i = 0; i < members.length; i++)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(1000),
                              child: Container(
                                  width: 30,
                                  height: 30,
                                  child: Center(
                                    child: Image.network(members[i]!),
                                  )),
                            )
                        ],
                      ),
                    ),
                  TextField(
                    onChanged: (value) {
                      if (value.trim().isEmpty)
                        return setState(() {
                          employeeList = widget.getemployeeList;
                        });
                      setState(() {
                        employeeList = [];
                      });

                      for (var i = 0; i < widget.getemployeeList.length; i++) {
                        if (widget.getemployeeList[i].name!
                            .toLowerCase()
                            .startsWith(value.toLowerCase().trim())) {
                          setState(() {
                            employeeList.add(widget.getemployeeList[i]);
                          });
                        }
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Search by member",
                      hintStyle: GoogleFonts.ptSans(
                          color: GlobalColors.light,
                          fontSize: width < 500 ? width / 40 : width / 35),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 20.0),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0.4, color: GlobalColors.light)
                          //<-- SEE HERE
                          ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          for (var i = 0; i < employeeList.length; i++)
                            InkWell(
                              onTap: () {
                                widget.onClick({
                                  "name": employeeList[i].name,
                                  "id": employeeList[i].id,
                                  "image": employeeList[i].imageUrl,
                                });
                                if (members.isEmpty) {
                                  return setState(() {
                                    members.add(employeeList[i].imageUrl);
                                  });
                                }
                                if (members
                                    .contains(employeeList[i].imageUrl)) {
                                  return setState(() {
                                    members.remove(employeeList[i].imageUrl);
                                  });
                                } else {
                                  return setState(() {
                                    members.add(employeeList[i].imageUrl);
                                  });
                                }
                              },
                              child: Card(
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      Container(
                                          width: width * 0.07,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: Image.network(
                                              employeeList[i].imageUrl!,
                                              width: 20,
                                            ),
                                          )),
                                      Expanded(
                                        child: Text(
                                          "${employeeList[i].name}",
                                          style: GoogleFonts.josefinSans(
                                              color: GlobalColors.dark,
                                              fontSize: width < 500
                                                  ? width / 33
                                                  : width / 35),
                                        ),
                                      ),
                                      if (members
                                          .contains(employeeList[i].imageUrl))
                                        Container(
                                            width: width * 0.1,
                                            child: Center(
                                              child: Icon(
                                                Icons.star,
                                                size: width < 500
                                                    ? width / 33
                                                    : width / 35,
                                                color: GlobalColors.orange,
                                              ),
                                            )),
                                    ],
                                  ),
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ));
  }
}
