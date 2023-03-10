// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:w3cert/api/api.dart';
import 'package:w3cert/const/const.dart';
import 'package:w3cert/provider/providers.dart';
import 'package:w3cert/screens/task/widgets/category-list.dart';
import 'package:w3cert/screens/task/widgets/multi-participant.dart';
import 'package:w3cert/screens/task/widgets/project-list.dart';
import '../../../models/categoryModel.dart';
import '../../../models/projectModel.dart';

class AddTask extends ConsumerStatefulWidget {
  final Function onClick;
  const AddTask({
    Key? key,
    required this.onClick,
  }) : super(key: key);

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends ConsumerState<AddTask> {
  String? project = "";
  String priority = "low";
  List<ProjectModel> projectList = [];

  int? projectId = 0;
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();

  String? category = "";
  int? categoryId = 0;

  DateTime startDate = DateTime.now();
  DateTime dueDate = DateTime.now();

  List<Map<String, dynamic>> members = [];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final data = ref.watch(projectProvider);
    final categoryData = ref.watch(CategoryProvider);
    final employeeDate = ref.watch(employeProvider);

    setPriority(value) {
      setState(() {
        priority = value;
      });
      Navigator.pop(context);
    }

    getProject(ProjectModel projectList) {
      setState(() {
        project = projectList.projectName;

        projectId = projectList.id;
      });
      Navigator.pop(context);
    }

    getCategory(CategoryModel catgoryList) {
      setState(() {
        category = catgoryList.categoryName;
        categoryId = catgoryList.id;
      });
      Navigator.pop(context);
    }

    multiMember(Map<String, dynamic> value) {
      print(value.toString());
      if (members.isEmpty)
        return setState(() {
          members.add({
            "name": value["name"],
            "id": value["id"],
            "image": value["image"]
          });
        });
      var data = members.where((e) => (e["name"].contains(value["name"])));

      if (data.isEmpty) {
        setState(() {
          members.add({
            "name": value["name"],
            "id": value["id"],
            "image": value["image"] ?? ""
          });
        });
      } else {
        setState(() {
          members.removeWhere((element) => element["id"] == value["id"]);
        });
      }
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "AddTask",
            style: GoogleFonts.ptSans(
                color: GlobalColors.white,
                fontSize: width < 500 ? width / 25 : width / 35),
          ),
        ),
        body: Container(
          height: height,
          width: width,
          child: Column(
            children: [
              Card(
                elevation: 10,
                child: Container(
                  height: height * 0.55,
                  width: width,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          showDialog<void>(
                            context: context,
                            barrierDismissible: true,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  "Projects",
                                  style: GoogleFonts.ptSans(
                                      color: GlobalColors.themeColor,
                                      fontSize: width < 500
                                          ? width / 25
                                          : width / 35),
                                ),
                                content: Container(
                                  height: height * 0.8,
                                  width: width,
                                  child: data.when(data: (_data) {
                                    projectList = _data;
                                    return ProjectList(
                                      getProjectList: _data,
                                      onclick: getProject,
                                    );
                                  }, error: (e, s) {
                                    return Text(e.toString());
                                  }, loading: () {
                                    return Center(
                                        child: CircularProgressIndicator
                                            .adaptive());
                                  }),
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
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
                                  "Project",
                                  style: GoogleFonts.ptSans(
                                      color: GlobalColors.light,
                                      fontSize: width < 500
                                          ? width / 35
                                          : width / 35),
                                ),
                              ),
                              Container(
                                width: width * 0.6,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  project!,
                                  style: GoogleFonts.ptSans(
                                      color: GlobalColors.dark,
                                      fontSize: width < 500
                                          ? width / 35
                                          : width / 35),
                                ),
                              ),
                              Container(
                                width: width * 0.1,
                                child: Icon(
                                  Icons.layers_outlined,
                                  size: width < 500 ? width / 28 : width / 35,
                                  color: GlobalColors.light,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          showDialog<void>(
                            context: context,
                            barrierDismissible: true,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  "Categories",
                                  style: GoogleFonts.ptSans(
                                      color: GlobalColors.themeColor,
                                      fontSize: width < 500
                                          ? width / 25
                                          : width / 35),
                                ),
                                content: Container(
                                  height: height * 0.8,
                                  width: width,
                                  child: categoryData.when(data: (_data) {
                                    return CategoryList(
                                      getcategoryList: _data,
                                      onclick: getCategory,
                                    );
                                  }, error: (e, s) {
                                    return Text(e.toString());
                                  }, loading: () {
                                    return Center(
                                        child: CircularProgressIndicator
                                            .adaptive());
                                  }),
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
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
                                  "Category",
                                  style: GoogleFonts.ptSans(
                                      color: GlobalColors.light,
                                      fontSize: width < 500
                                          ? width / 35
                                          : width / 35),
                                ),
                              ),
                              Container(
                                width: width * 0.6,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  category!,
                                  style: GoogleFonts.ptSans(
                                      color: GlobalColors.dark,
                                      fontSize: width < 500
                                          ? width / 35
                                          : width / 35),
                                ),
                              ),
                              Container(
                                width: width * 0.1,
                                child: Icon(
                                  Icons.category,
                                  size: width < 500 ? width / 28 : width / 35,
                                  color: GlobalColors.light,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
                              width: width * 0.15,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Title *",
                                style: GoogleFonts.ptSans(
                                    color: GlobalColors.light,
                                    fontSize:
                                        width < 500 ? width / 35 : width / 35),
                              ),
                            ),
                            Container(
                              width: width * 0.7,
                              child: TextFormField(
                                controller: _title,
                                decoration: const InputDecoration(
                                    hintText: "Eg.New Task"),
                                style: GoogleFonts.ptSans(
                                    color: GlobalColors.dark,
                                    fontSize:
                                        width < 500 ? width / 30 : width / 35),
                                keyboardType: TextInputType.streetAddress,
                                onSaved: (String? value) {},
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          showDialog<void>(
                            context: context,
                            barrierDismissible: true,
                            builder: (context) {
                              return employeeDate.when(data: (_data) {
                                return MultiSelectParticipant(
                                  getemployeeList: _data,
                                  onClick: multiMember,
                                  selectedMember: members,
                                );
                              }, error: (error, stackTrace) {
                                return Center(child: Text("e"));
                              }, loading: () {
                                return Text("");
                              });
                            },
                          );
                        },
                        child: Container(
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
                                  "Members *",
                                  style: GoogleFonts.ptSans(
                                      color: GlobalColors.light,
                                      fontSize: width < 500
                                          ? width / 35
                                          : width / 35),
                                ),
                              ),
                              Container(
                                width: width * 0.6,
                                alignment: Alignment.center,
                                child: Row(
                                  children: [
                                    for (var i = 0; i < members.length; i++)
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(1000),
                                        child: Container(
                                            width: 30,
                                            height: 30,
                                            child: Center(
                                              child: Image.network(
                                                  members[i]["image"]),
                                            )),
                                      )
                                  ],
                                ),
                              ),
                              Container(
                                width: width * 0.1,
                                child: Icon(
                                  Icons.person_3,
                                  size: width < 500 ? width / 28 : width / 35,
                                  color: GlobalColors.light,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          showDialog<void>(
                            context: context,
                            barrierDismissible: true,
                            builder: (context) {
                              return AlertDialog(
                                content: Container(
                                  width: width * 0.5,
                                  height: height * 0.12,
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setPriority("low");
                                        },
                                        child: Card(
                                          child: Container(
                                            width: width,
                                            height: height * 0.03,
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Low",
                                              style: GoogleFonts.ptSans(
                                                  color: GlobalColors.light,
                                                  fontSize: width < 500
                                                      ? width / 35
                                                      : width / 35),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                          onTap: () {
                                            setPriority("medium");
                                          },
                                          child: Card(
                                            child: Container(
                                              width: width,
                                              height: height * 0.03,
                                              alignment: Alignment.center,
                                              child: Text(
                                                "Medium",
                                                style: GoogleFonts.ptSans(
                                                    color: GlobalColors.light,
                                                    fontSize: width < 500
                                                        ? width / 35
                                                        : width / 35),
                                              ),
                                            ),
                                          )),
                                      InkWell(
                                          onTap: () {
                                            setPriority("high");
                                          },
                                          child: Card(
                                            child: Container(
                                              width: width,
                                              height: height * 0.03,
                                              alignment: Alignment.center,
                                              child: Text(
                                                "High",
                                                style: GoogleFonts.ptSans(
                                                    color: GlobalColors.light,
                                                    fontSize: width < 500
                                                        ? width / 35
                                                        : width / 35),
                                              ),
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
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
                                  "Priority *",
                                  style: GoogleFonts.ptSans(
                                      color: GlobalColors.light,
                                      fontSize: width < 500
                                          ? width / 35
                                          : width / 35),
                                ),
                              ),
                              Container(
                                width: width * 0.6,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  priority,
                                  style: GoogleFonts.ptSans(
                                      color: GlobalColors.dark,
                                      fontSize: width < 500
                                          ? width / 35
                                          : width / 35),
                                ),
                              ),
                              Container(
                                width: width * 0.1,
                                child: Icon(
                                  Icons.priority_high,
                                  size: width < 500 ? width / 28 : width / 35,
                                  color: GlobalColors.light,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  currentDate: startDate,
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2300))
                              .then((value) {
                            setState(() {
                              startDate = value!;
                            });
                          });
                        },
                        child: Container(
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
                                  "Start Date",
                                  style: GoogleFonts.ptSans(
                                      color: GlobalColors.light,
                                      fontSize: width < 500
                                          ? width / 35
                                          : width / 35),
                                ),
                              ),
                              Container(
                                width: width * 0.6,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  DateFormat("dd-MM-yyyy").format(startDate),
                                  style: GoogleFonts.ptSans(
                                      color: GlobalColors.dark,
                                      fontSize: width < 500
                                          ? width / 35
                                          : width / 35),
                                ),
                              ),
                              Container(
                                width: width * 0.1,
                                child: Icon(
                                  Icons.calendar_month,
                                  size: width < 500 ? width / 28 : width / 35,
                                  color: GlobalColors.light,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  currentDate: dueDate,
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2300))
                              .then((value) {
                            setState(() {
                              dueDate = value!;
                            });
                          });
                        },
                        child: Container(
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
                                  "Due Date",
                                  style: GoogleFonts.ptSans(
                                      color: GlobalColors.light,
                                      fontSize: width < 500
                                          ? width / 35
                                          : width / 35),
                                ),
                              ),
                              Container(
                                width: width * 0.6,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  DateFormat("dd-MM-yyyy").format(dueDate),
                                  style: GoogleFonts.ptSans(
                                      color: GlobalColors.dark,
                                      fontSize: width < 500
                                          ? width / 35
                                          : width / 35),
                                ),
                              ),
                              Container(
                                width: width * 0.1,
                                child: Icon(
                                  Icons.calendar_month,
                                  size: width < 500 ? width / 28 : width / 35,
                                  color: GlobalColors.light,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
                              width: width * 0.15,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Description",
                                style: GoogleFonts.ptSans(
                                    color: GlobalColors.light,
                                    fontSize:
                                        width < 500 ? width / 35 : width / 35),
                              ),
                            ),
                            Container(
                              width: width * 0.7,
                              child: TextFormField(
                                controller: _description,
                                decoration: const InputDecoration(
                                    hintText: "Eg.New Task"),
                                style: GoogleFonts.ptSans(
                                    color: GlobalColors.dark,
                                    fontSize:
                                        width < 500 ? width / 30 : width / 35),
                                keyboardType: TextInputType.streetAddress,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromARGB(255, 224, 222, 222)),
                              child: Text(
                                "cancel",
                                style: GoogleFonts.ptSans(
                                    color: Color.fromARGB(255, 99, 96, 96),
                                    fontSize:
                                        width < 500 ? width / 25 : width / 35),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                List<int> userList = [];
                                members
                                    .map((e) => userList.add(e["id"]))
                                    .toList();

                                if (_title.text.trim().isEmpty)
                                  return customAlert(context, width, height,
                                      false, "Please give any title");

                                if (userList.isEmpty)
                                  return customAlert(
                                      context,
                                      width,
                                      height,
                                      false,
                                      "Please select atlease one member");

                                Map<String, dynamic> formData = {
                                  "heading": _title.text,
                                  "description": _description.text,
                                  "start_date": DateFormat("dd-MM-yyyy")
                                      .format(startDate)
                                      .toString(),
                                  "due_date": DateFormat("dd-MM-yyyy")
                                      .format(dueDate)
                                      .toString(),
                                  "priority": priority,
                                  "without_duedate": null,
                                  "project_id": projectId == 0 ? "" : projectId,
                                  "category_id":
                                      categoryId == 0 ? "" : categoryId,
                                  "user_id[]": userList
                                };
                                Api()
                                    .addTask(ref.watch(tokenProvider), formData)
                                    .then((value) {
                                  if (value.statusCode.toString() == "200")
                                    return customAlert(context, width, height,
                                        true, "Task Created Successfully!");
                                  ;
                                  widget.onClick();
                                  customAlert(context, width, height, false,
                                      "Something went wrong!!!!");
                                  Navigator.pop(context);
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromARGB(255, 228, 240, 250)),
                              child: Text(
                                "Add",
                                style: GoogleFonts.ptSans(
                                    color: GlobalColors.blue,
                                    fontSize:
                                        width < 500 ? width / 25 : width / 35),
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
        ),
      ),
    );
  }
}
