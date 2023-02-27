import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../const/const.dart';
import '../../../models/projectModel.dart';

class ProjectList extends StatefulWidget {
  final List<ProjectModel> getProjectList;
  final Function onclick;
  const ProjectList(
      {Key? key, required this.getProjectList, required this.onclick})
      : super(key: key);

  @override
  _ProjectListState createState() => _ProjectListState();
}

class _ProjectListState extends State<ProjectList> {
  List<ProjectModel> projectList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      projectList = widget.getProjectList;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
        child: SingleChildScrollView(
      child: Column(
        children: [
          TextField(
            onChanged: (value) {
              if (value.trim().isEmpty)
                return setState(() {
                  projectList = widget.getProjectList;
                });
              setState(() {
                projectList = [];
              });

              for (var i = 0; i < widget.getProjectList.length; i++) {
                if (widget.getProjectList[i].projectName!
                    .toLowerCase()
                    .startsWith(value.toLowerCase().trim())) {
                  setState(() {
                    projectList.add(widget.getProjectList[i]);
                  });
                }
              }
            },
            decoration: InputDecoration(
              hintText: "Search by project",
              hintStyle: GoogleFonts.ptSans(
                  color: GlobalColors.light,
                  fontSize: width < 500 ? width / 40 : width / 35),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0.4, color: GlobalColors.light)
                  //<-- SEE HERE
                  ),
            ),
          ),
          for (var i = 0; i < projectList.length; i++)
            InkWell(
                onTap: () {
                  widget.onclick(projectList[i]);
                },
                child: Card(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Container(
                          width: width * 0.1,
                          child: Icon(Icons.layers,
                              color: GlobalColors.blue,
                              size: width < 500 ? width / 32 : width / 35),
                        ),
                        Expanded(
                          child: Text(
                            "${projectList[i].projectName}",
                            style: GoogleFonts.ptSans(
                                color: GlobalColors.dark,
                                fontSize:
                                    width < 500 ? width / 33 : width / 35),
                          ),
                        ),
                      ],
                    ),
                  ),
                ))
        ],
      ),
    ));
  }
}
