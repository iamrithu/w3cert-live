// ignore_for_file: library_private_types_in_public_api

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:w3cert/api/api.dart';
import 'package:w3cert/const/const.dart';
import 'package:w3cert/models/leadModel.dart';
import 'package:w3cert/provider/providers.dart';
import 'package:w3cert/screens/leads/widgets/add-leads.dart';

import '../../../router/routing-const.dart';
import '../../../widgets/custom-drawer.dart';

List<String> options = [
  "View",
  "Delete",
  "Add to client",
  "Add followup",
  "Next followup"
];

class LeadsList extends ConsumerStatefulWidget {
  final Function onclick;
  final List<LeadModel> lead;
  const LeadsList({
    Key? key,
    required this.lead,
    required this.onclick,
  }) : super(key: key);

  @override
  _LeadsListState createState() => _LeadsListState();
}

class _LeadsListState extends ConsumerState<LeadsList> {
  final TextEditingController search = TextEditingController();

  List<LeadModel> lead = [];
  String selectedOption = options[0];
  bool searchBar = false;
  bool isVisible = false;

  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a ke

  @override
  void initState() {
    super.initState();
    lead = widget.lead;

    print(lead[0].toJson().toString());
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet<void>(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return FractionallySizedBox(
                    heightFactor: 0.95,
                    child: Container(
                      height: height,
                      child: AddLeads(
                        onClick: widget.onclick,
                      ),
                    ),
                  );
                },
              );
            },
            child: Icon(Icons.add), // <-- Opens drawer
          ),
          key: _key,
          appBar: AppBar(
            title: InkWell(
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
                    setState(() {
                      isVisible = !isVisible;
                      searchBar = !searchBar;
                      lead = widget.lead;
                      search.text = "";
                    });
                  },
                  icon: Icon(Icons.search)),
              IconButton(
                  onPressed: () {
                    context
                        .pushReplacementNamed(RoutingConstants.notifications);
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
          body: Column(
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                color: GlobalColors.themeColor,
                width: width,
                height: searchBar ? 50 : 0,
                child: Visibility(
                  visible: isVisible,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: GlobalColors.white,
                              borderRadius: BorderRadius.circular(4),
                              border:
                                  Border.all(color: GlobalColors.themeColor)),
                          margin: EdgeInsets.all(2),
                          child: TextFormField(
                            controller: search,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(bottom: 4, left: 10),
                              border: InputBorder.none,
                              hintText: 'Search by client',
                              hintStyle: GoogleFonts.ptSans(
                                  color: GlobalColors.light,
                                  fontWeight: FontWeight.w100,
                                  fontSize:
                                      width < 500 ? width / 35 : width / 55),
                            ),
                            onChanged: (value) {
                              if (value.trim() == "") {
                                return setState(() {
                                  lead = widget.lead;
                                });
                              }
                              setState(() {
                                lead = [];
                              });
                              for (var i = 0; i < widget.lead.length; i++) {
                                if (widget.lead[i].clientName!
                                    .toLowerCase()
                                    .startsWith(value.toLowerCase())) {
                                  setState(() {
                                    lead.add(widget.lead[i]);
                                  });
                                }
                              }
                            },
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (search.text.trim().isNotEmpty) {
                            return setState(() {
                              search.text = "";
                              lead = widget.lead;
                            });
                          }
                          return setState(() {
                            isVisible = !isVisible;
                            searchBar = false;
                          });
                        },
                        child: Container(
                          width: width * 0.1,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: GlobalColors.themeColor,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: GlobalColors.white)),
                          margin: EdgeInsets.all(2),
                          child: Center(
                              child: FaIcon(
                            FontAwesomeIcons.xmark,
                            size: width < 500 ? width / 30 : width / 55,
                            color: GlobalColors.white,
                          )),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (var i = 0; i < lead.length; i++)
                        InkWell(
                          onTap: () {},
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                                side: BorderSide(
                                    color: Color.fromARGB(255, 155, 202, 244),
                                    width: 0.5)),
                            child: Container(
                              constraints: BoxConstraints(
                                  minHeight: height * 0.13,
                                  minWidth: width * 0.95),
                              // width: width * 0.95,
                              // height: height * 0.13,
                              padding: EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 212, 213, 213),
                                                width: 0.5))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            FaIcon(
                                              FontAwesomeIcons.user,
                                              size: width < 500
                                                  ? width / 40
                                                  : width / 65,
                                              color: GlobalColors.light,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                "${lead[i].clientName}",
                                                style: GoogleFonts.ptSans(
                                                    color: GlobalColors.dark,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: width < 500
                                                        ? width / 35
                                                        : width / 55),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(left: 5),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: lead[i].statusName ==
                                                        "pending"
                                                    ? Color.fromARGB(
                                                        255, 255, 239, 221)
                                                    : Color.fromARGB(
                                                        255, 219, 255, 220),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 3, horizontal: 4),
                                              child: Wrap(
                                                children: [
                                                  Text(
                                                    "${lead[i].statusName}",
                                                    style: GoogleFonts.josefinSans(
                                                        color:
                                                            lead[i].statusName ==
                                                                    "pending"
                                                                ? GlobalColors
                                                                    .orange
                                                                : GlobalColors
                                                                    .green,
                                                        fontSize: width < 500
                                                            ? width / 40
                                                            : width / 55),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: width * 0.1),
                                          child: InkWell(
                                            onTap: () {},
                                            child: PopupMenuButton(
                                              padding: EdgeInsets.all(1),
                                              initialValue: selectedOption,
                                              // Callback that sets the selected popup menu item.
                                              onSelected: (item) {
                                                if (item == "Delete") {
                                                  Api()
                                                      .leadDelete(
                                                          ref.watch(
                                                              tokenProvider),
                                                          lead[i].id!)
                                                      .then((value) {
                                                    if (value.statusCode
                                                            .toString() ==
                                                        "500")
                                                      return customAlert(
                                                          context,
                                                          width,
                                                          height,
                                                          false,
                                                          "Something went wrong!!!!");
                                                    ;
                                                    widget.onclick();

                                                    setState(() {
                                                      lead.removeWhere(
                                                        (element) =>
                                                            element.id ==
                                                            lead[i].id!,
                                                      );
                                                    });

                                                    customAlert(
                                                        context,
                                                        width,
                                                        height,
                                                        true,
                                                        "Lead Deleted Successfully!");
                                                  });
                                                }

                                                if (item == "Add followup") {}
                                              },
                                              itemBuilder:
                                                  (BuildContext context) => [
                                                PopupMenuItem(
                                                  value: options[0],
                                                  child: Row(
                                                    children: [
                                                      FaIcon(
                                                        FontAwesomeIcons
                                                            .usersViewfinder,
                                                        size: width < 500
                                                            ? width / 40
                                                            : width / 65,
                                                        color:
                                                            GlobalColors.dark,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 8.0),
                                                        child: Text(
                                                          options[0],
                                                          style: GoogleFonts.ptSans(
                                                              color:
                                                                  GlobalColors
                                                                      .dark,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: width <
                                                                      500
                                                                  ? width / 35
                                                                  : width / 55),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                PopupMenuItem(
                                                  value: options[1],
                                                  child: Row(
                                                    children: [
                                                      FaIcon(
                                                        Icons.delete,
                                                        size: width < 500
                                                            ? width / 35
                                                            : width / 65,
                                                        color:
                                                            GlobalColors.dark,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 8.0),
                                                        child: Text(
                                                          options[1],
                                                          style: GoogleFonts.ptSans(
                                                              color:
                                                                  GlobalColors
                                                                      .dark,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: width <
                                                                      500
                                                                  ? width / 35
                                                                  : width / 55),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                PopupMenuItem(
                                                  value: options[2],
                                                  child: Row(
                                                    children: [
                                                      FaIcon(
                                                        Icons.person,
                                                        size: width < 500
                                                            ? width / 30
                                                            : width / 65,
                                                        color:
                                                            GlobalColors.dark,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8.0),
                                                        child: Text(
                                                          options[2],
                                                          style: GoogleFonts.ptSans(
                                                              color:
                                                                  GlobalColors
                                                                      .dark,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: width <
                                                                      500
                                                                  ? width / 35
                                                                  : width / 55),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                PopupMenuItem(
                                                  value: options[3],
                                                  child: Row(
                                                    children: [
                                                      FaIcon(
                                                        Icons.add_task,
                                                        size: width < 500
                                                            ? width / 30
                                                            : width / 65,
                                                        color:
                                                            GlobalColors.dark,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 8.0),
                                                        child: Text(
                                                          options[3],
                                                          style: GoogleFonts.ptSans(
                                                              color:
                                                                  GlobalColors
                                                                      .dark,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: width <
                                                                      500
                                                                  ? width / 35
                                                                  : width / 55),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                PopupMenuItem(
                                                  value: options[4],
                                                  child: Row(
                                                    children: [
                                                      FaIcon(
                                                        FontAwesomeIcons
                                                            .rightFromBracket,
                                                        size: width < 500
                                                            ? width / 35
                                                            : width / 65,
                                                        color:
                                                            GlobalColors.dark,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 8.0),
                                                        child: Text(
                                                          options[4],
                                                          style: GoogleFonts.ptSans(
                                                              color:
                                                                  GlobalColors
                                                                      .dark,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: width <
                                                                      500
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
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Row(
                                      children: [
                                        FaIcon(
                                          Icons.factory,
                                          size: width < 500
                                              ? width / 40
                                              : width / 65,
                                          color: GlobalColors.light,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            "${lead[i].companyName ?? "--"}",
                                            style: GoogleFonts.ptSans(
                                                color: GlobalColors.light,
                                                fontWeight: FontWeight.w300,
                                                fontSize: width < 500
                                                    ? width / 40
                                                    : width / 60),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      FaIcon(
                                        Icons.phone,
                                        size: width < 500
                                            ? width / 40
                                            : width / 65,
                                        color: GlobalColors.light,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          "${lead[i].mobile}",
                                          style: GoogleFonts.ptSans(
                                              color: GlobalColors.light,
                                              fontWeight: FontWeight.w600,
                                              fontSize: width < 500
                                                  ? width / 45
                                                  : width / 55),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.0),
                                    child: Row(
                                      children: [
                                        lead[i].leadAgent == null
                                            ? Text(
                                                "${" --"}",
                                                style: GoogleFonts.ptSans(
                                                    color: GlobalColors.light,
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: width < 500
                                                        ? width / 40
                                                        : width / 60),
                                              )
                                            : Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 4, vertical: 2),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10000),
                                                    color: Color.fromARGB(
                                                        255, 232, 232, 232)),
                                                child: Row(
                                                  children: [
                                                    CircleAvatar(
                                                      maxRadius: width < 500
                                                          ? width / 50
                                                          : width / 80,
                                                      foregroundImage:
                                                          NetworkImage(lead[i]
                                                              .leadAgent!
                                                              .user!
                                                              .imageUrl!),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0),
                                                      child: Text(
                                                        "${lead[i].agentName}",
                                                        style:
                                                            GoogleFonts.ptSans(
                                                                color:
                                                                    GlobalColors
                                                                        .light,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800,
                                                                fontSize: width <
                                                                        500
                                                                    ? width / 50
                                                                    : width /
                                                                        60),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
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
                ),
              ),
            ],
          )),
    );
  }
}
