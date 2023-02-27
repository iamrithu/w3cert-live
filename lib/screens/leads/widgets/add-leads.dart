// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:w3cert/const/const.dart';

import '../../../api/api.dart';
import '../../../provider/providers.dart';
import '../../../router/routing-const.dart';

List<String> salutationList = ["Mr", "Mrs", "Miss", "Dr", "Sir", "Madam"];

class AddLeads extends ConsumerStatefulWidget {
  final Function onClick;
  const AddLeads({
    Key? key,
    required this.onClick,
  }) : super(key: key);

  @override
  _AddLeadsState createState() => _AddLeadsState();
}

class _AddLeadsState extends ConsumerState<AddLeads> {
  late TextEditingController _leadNameController = TextEditingController();
  late TextEditingController _leadEmailController = TextEditingController();
  late TextEditingController _leadValueController = TextEditingController();
  late TextEditingController _leadCompanyController = TextEditingController();
  late TextEditingController _leadWebsiteController = TextEditingController();
  late TextEditingController _leadMobileController = TextEditingController();
  late TextEditingController _leadStateController = TextEditingController();
  late TextEditingController _leadCityController = TextEditingController();
  late TextEditingController _leadPostalController = TextEditingController();
  late TextEditingController _leadAddressController = TextEditingController();
  late TextEditingController _leadNoteController = TextEditingController();

  String salutation = salutationList.first;
  String? leadAgendName = "--";
  String? followUp = "Yes";

  int? leadAgendId = 0;
  String? sourceName = "--";
  int? leadStatusId = 0;
  String? statusName = "--";
  int? sourceId = 0;
  String? categoryName = "--";
  int? categoryId = 0;
  String? country = "--";
  int? countryId = 0;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final leadAgend = ref.watch(leadAgendProvider);
    final leadSource = ref.watch(leadSourceProvider);
    final leadCategory = ref.watch(leadCategoryProvider);
    final leadCountry = ref.watch(leadCountryProvider);
    final leadStatus = ref.watch(leadStatusProvider);

    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   automaticallyImplyLeading: false,
        //   title: Text(
        //     "AddLeads",
        //     style: GoogleFonts.ptSans(
        //         color: GlobalColors.white,
        //         fontSize: width < 500 ? width / 25 : width / 35),
        //   ),
        // ),
        body: Card(
          child: Container(
            height: height,
            width: width,
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: width,
                    child: Text(
                      "Add Lead :",
                      style: GoogleFonts.ptSans(
                          color: GlobalColors.dark,
                          fontWeight: FontWeight.bold,
                          fontSize: width < 500 ? width / 30 : width / 50),
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
                          child: Text(
                            "Lead Name:",
                            style: GoogleFonts.ptSans(
                                color: GlobalColors.light,
                                fontSize:
                                    width < 500 ? width / 35 : width / 60),
                          ),
                        ),
                        Container(
                            width: width * 0.2,
                            alignment: Alignment.centerLeft,
                            child: Center(
                              child: DropdownButton<String>(
                                borderRadius: BorderRadius.circular(4),
                                value: salutation,
                                underline: Text(""),
                                isExpanded: false,
                                autofocus: true,
                                //menuMaxHeight: height * 0.2,

                                onChanged: (String? value) {
                                  setState(() {
                                    salutation = value!;
                                  });
                                },
                                items: salutationList
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: GoogleFonts.ptSans(
                                        color: GlobalColors.light,
                                        fontSize: width < 700
                                            ? width / 30
                                            : width / 50,
                                        letterSpacing: 0,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            )),
                        Container(
                          width: width * 0.55,
                          child: TextFormField(
                            controller: _leadNameController,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Lead Name"),
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
                            "Email *",
                            style: GoogleFonts.ptSans(
                                color: GlobalColors.light,
                                fontSize:
                                    width < 500 ? width / 35 : width / 35),
                          ),
                        ),
                        Container(
                          width: width * 0.7,
                          child: TextFormField(
                            controller: _leadEmailController,
                            decoration: const InputDecoration(
                                border: InputBorder.none, hintText: "--"),
                            style: GoogleFonts.ptSans(
                                color: GlobalColors.dark,
                                fontSize:
                                    width < 500 ? width / 30 : width / 35),
                            keyboardType: TextInputType.emailAddress,
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
                          return AlertDialog(
                            title: Text(
                              "Agends",
                              style: GoogleFonts.ptSans(
                                  color: GlobalColors.themeColor,
                                  fontSize:
                                      width < 500 ? width / 25 : width / 35),
                            ),
                            content: Container(
                              width: width,
                              height: height * 0.2,
                              child: leadAgend.when(data: (_data) {
                                return Column(
                                  children: [
                                    for (var i = 0; i < _data.length; i++)
                                      InkWell(
                                          onTap: () {
                                            setState(() {
                                              leadAgendId = _data[i].id;
                                              leadAgendName =
                                                  _data[i].user!.name!;
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: Card(
                                            child: Container(
                                              padding: EdgeInsets.all(10),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: width * 0.1,
                                                    child: Icon(Icons.person,
                                                        color:
                                                            GlobalColors.blue,
                                                        size: width < 500
                                                            ? width / 32
                                                            : width / 35),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      "${_data[i].user!.name!}",
                                                      style: GoogleFonts.ptSans(
                                                          color:
                                                              GlobalColors.dark,
                                                          fontSize: width < 500
                                                              ? width / 33
                                                              : width / 35),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ))
                                  ],
                                );
                              }, error: (e, s) {
                                return Text(e.toString());
                              }, loading: () {
                                return Center(
                                    child:
                                        CircularProgressIndicator.adaptive());
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
                              "Agend",
                              style: GoogleFonts.ptSans(
                                  color: GlobalColors.light,
                                  fontSize:
                                      width < 500 ? width / 35 : width / 35),
                            ),
                          ),
                          Container(
                            width: width * 0.6,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "   " + leadAgendName!,
                              style: GoogleFonts.ptSans(
                                  color: GlobalColors.dark,
                                  fontSize:
                                      width < 500 ? width / 35 : width / 35),
                            ),
                          ),
                          Container(
                            width: width * 0.1,
                            child: Icon(
                              Icons.person,
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
                              "Source",
                              style: GoogleFonts.ptSans(
                                  color: GlobalColors.themeColor,
                                  fontSize:
                                      width < 500 ? width / 25 : width / 35),
                            ),
                            content: Container(
                              width: width,
                              height: height * 0.4,
                              child: leadSource.when(data: (_data) {
                                return SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      for (var i = 0; i < _data.length; i++)
                                        InkWell(
                                            onTap: () {
                                              setState(() {
                                                sourceId = _data[i].id;
                                                sourceName = _data[i].type;
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: Card(
                                              child: Container(
                                                padding: EdgeInsets.all(10),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width: width * 0.1,
                                                      child: Icon(Icons.source,
                                                          color:
                                                              GlobalColors.blue,
                                                          size: width < 500
                                                              ? width / 32
                                                              : width / 35),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        "${_data[i].type}",
                                                        style:
                                                            GoogleFonts.ptSans(
                                                                color:
                                                                    GlobalColors
                                                                        .dark,
                                                                fontSize: width <
                                                                        500
                                                                    ? width / 33
                                                                    : width /
                                                                        35),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ))
                                    ],
                                  ),
                                );
                              }, error: (e, s) {
                                return Text(e.toString());
                              }, loading: () {
                                return Center(
                                    child:
                                        CircularProgressIndicator.adaptive());
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
                              "Source",
                              style: GoogleFonts.ptSans(
                                  color: GlobalColors.light,
                                  fontSize:
                                      width < 500 ? width / 35 : width / 35),
                            ),
                          ),
                          Container(
                            width: width * 0.6,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "   " + sourceName!,
                              style: GoogleFonts.ptSans(
                                  color: GlobalColors.dark,
                                  fontSize:
                                      width < 500 ? width / 35 : width / 35),
                            ),
                          ),
                          Container(
                            width: width * 0.1,
                            child: Icon(
                              Icons.source,
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
                              "Category",
                              style: GoogleFonts.ptSans(
                                  color: GlobalColors.themeColor,
                                  fontSize:
                                      width < 500 ? width / 25 : width / 35),
                            ),
                            content: Container(
                              width: width,
                              height: height * 0.4,
                              child: leadCategory.when(data: (_data) {
                                return Column(
                                  children: [
                                    for (var i = 0; i < _data.length; i++)
                                      InkWell(
                                          onTap: () {
                                            setState(() {
                                              categoryId = _data[i].id;
                                              categoryName =
                                                  _data[i].categoryName;
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: Card(
                                            child: Container(
                                              padding: EdgeInsets.all(10),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: width * 0.1,
                                                    child: Icon(Icons.category,
                                                        color:
                                                            GlobalColors.blue,
                                                        size: width < 500
                                                            ? width / 32
                                                            : width / 35),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      "${_data[i].categoryName}",
                                                      style: GoogleFonts.ptSans(
                                                          color:
                                                              GlobalColors.dark,
                                                          fontSize: width < 500
                                                              ? width / 33
                                                              : width / 35),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ))
                                  ],
                                );
                              }, error: (e, s) {
                                return Text(e.toString());
                              }, loading: () {
                                return Center(
                                    child:
                                        CircularProgressIndicator.adaptive());
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
                                  fontSize:
                                      width < 500 ? width / 35 : width / 35),
                            ),
                          ),
                          Container(
                            width: width * 0.6,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "   " + categoryName!,
                              style: GoogleFonts.ptSans(
                                  color: GlobalColors.dark,
                                  fontSize:
                                      width < 500 ? width / 35 : width / 35),
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
                  InkWell(
                    onTap: () {
                      showDialog<void>(
                        context: context,
                        barrierDismissible: true,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              "Add Follow Up",
                              style: GoogleFonts.ptSans(
                                  color: GlobalColors.themeColor,
                                  fontSize:
                                      width < 500 ? width / 25 : width / 35),
                            ),
                            content: Container(
                              width: width,
                              height: height * 0.1,
                              child: leadAgend.when(data: (_data) {
                                return Column(
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          setState(() {
                                            followUp = "Yes";
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Card(
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: width * 0.1,
                                                  child: Icon(
                                                      Icons.follow_the_signs,
                                                      color: GlobalColors.blue,
                                                      size: width < 500
                                                          ? width / 32
                                                          : width / 35),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    "Yes",
                                                    style: GoogleFonts.ptSans(
                                                        color:
                                                            GlobalColors.dark,
                                                        fontSize: width < 500
                                                            ? width / 33
                                                            : width / 35),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )),
                                    InkWell(
                                        onTap: () {
                                          setState(() {
                                            followUp = "No";
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Card(
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: width * 0.1,
                                                  child: Icon(
                                                      Icons.follow_the_signs,
                                                      color: GlobalColors.blue,
                                                      size: width < 500
                                                          ? width / 32
                                                          : width / 35),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    "No",
                                                    style: GoogleFonts.ptSans(
                                                        color:
                                                            GlobalColors.dark,
                                                        fontSize: width < 500
                                                            ? width / 33
                                                            : width / 35),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ))
                                  ],
                                );
                              }, error: (e, s) {
                                return Text(e.toString());
                              }, loading: () {
                                return Center(
                                    child:
                                        CircularProgressIndicator.adaptive());
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
                              "Follow Up",
                              style: GoogleFonts.ptSans(
                                  color: GlobalColors.light,
                                  fontSize:
                                      width < 500 ? width / 35 : width / 35),
                            ),
                          ),
                          Container(
                            width: width * 0.6,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "   " + followUp!,
                              style: GoogleFonts.ptSans(
                                  color: GlobalColors.dark,
                                  fontSize:
                                      width < 500 ? width / 35 : width / 35),
                            ),
                          ),
                          Container(
                            width: width * 0.1,
                            child: Icon(
                              Icons.follow_the_signs,
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
                              "Status",
                              style: GoogleFonts.ptSans(
                                  color: GlobalColors.themeColor,
                                  fontSize:
                                      width < 500 ? width / 25 : width / 35),
                            ),
                            content: Container(
                              width: width,
                              height: height * 0.4,
                              child: leadStatus.when(data: (_data) {
                                return Column(
                                  children: [
                                    for (var i = 0; i < _data.length; i++)
                                      InkWell(
                                          onTap: () {
                                            setState(() {
                                              leadStatusId = _data[i].id;
                                              statusName = _data[i].type!;
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: Card(
                                            child: Container(
                                              padding: EdgeInsets.all(10),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: width * 0.1,
                                                    child: Icon(Icons.info,
                                                        color:
                                                            GlobalColors.blue,
                                                        size: width < 500
                                                            ? width / 32
                                                            : width / 35),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      "${_data[i].type}",
                                                      style: GoogleFonts.ptSans(
                                                          color:
                                                              GlobalColors.dark,
                                                          fontSize: width < 500
                                                              ? width / 33
                                                              : width / 35),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ))
                                  ],
                                );
                              }, error: (e, s) {
                                return Text(e.toString());
                              }, loading: () {
                                return Center(
                                    child:
                                        CircularProgressIndicator.adaptive());
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
                              "Status",
                              style: GoogleFonts.ptSans(
                                  color: GlobalColors.light,
                                  fontSize:
                                      width < 500 ? width / 35 : width / 35),
                            ),
                          ),
                          Container(
                            width: width * 0.6,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "   " + statusName!,
                              style: GoogleFonts.ptSans(
                                  color: GlobalColors.dark,
                                  fontSize:
                                      width < 500 ? width / 35 : width / 35),
                            ),
                          ),
                          Container(
                            width: width * 0.1,
                            child: Icon(
                              Icons.info,
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
                            "Lead Value",
                            style: GoogleFonts.ptSans(
                                color: GlobalColors.light,
                                fontSize:
                                    width < 500 ? width / 35 : width / 35),
                          ),
                        ),
                        Container(
                          width: width * 0.7,
                          child: TextFormField(
                            controller: _leadValueController,
                            decoration: const InputDecoration(
                                border: InputBorder.none, hintText: "--"),
                            style: GoogleFonts.ptSans(
                                color: GlobalColors.dark,
                                fontSize:
                                    width < 500 ? width / 30 : width / 35),
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (String? value) {},
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
                            "Company",
                            style: GoogleFonts.ptSans(
                                color: GlobalColors.light,
                                fontSize:
                                    width < 500 ? width / 35 : width / 35),
                          ),
                        ),
                        Container(
                          width: width * 0.7,
                          child: TextFormField(
                            controller: _leadCompanyController,
                            decoration: const InputDecoration(
                                border: InputBorder.none, hintText: "--"),
                            style: GoogleFonts.ptSans(
                                color: GlobalColors.dark,
                                fontSize:
                                    width < 500 ? width / 30 : width / 35),
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (String? value) {},
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
                            "Website",
                            style: GoogleFonts.ptSans(
                                color: GlobalColors.light,
                                fontSize:
                                    width < 500 ? width / 35 : width / 35),
                          ),
                        ),
                        Container(
                          width: width * 0.7,
                          child: TextFormField(
                            controller: _leadWebsiteController,
                            decoration: const InputDecoration(
                                border: InputBorder.none, hintText: "--"),
                            style: GoogleFonts.ptSans(
                                color: GlobalColors.dark,
                                fontSize:
                                    width < 500 ? width / 30 : width / 35),
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (String? value) {},
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
                            "Mobile No",
                            style: GoogleFonts.ptSans(
                                color: GlobalColors.light,
                                fontSize:
                                    width < 500 ? width / 35 : width / 35),
                          ),
                        ),
                        Container(
                          width: width * 0.7,
                          child: TextFormField(
                            controller: _leadMobileController,
                            decoration: const InputDecoration(
                                border: InputBorder.none, hintText: "--"),
                            style: GoogleFonts.ptSans(
                                color: GlobalColors.dark,
                                fontSize:
                                    width < 500 ? width / 30 : width / 35),
                            keyboardType: TextInputType.emailAddress,
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
                          return AlertDialog(
                            title: Text(
                              "Country",
                              style: GoogleFonts.ptSans(
                                  color: GlobalColors.themeColor,
                                  fontSize:
                                      width < 500 ? width / 25 : width / 35),
                            ),
                            content: Container(
                              width: width,
                              height: height * 0.7,
                              child: leadCountry.when(data: (_data) {
                                return SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      for (var i = 0; i < _data.length; i++)
                                        InkWell(
                                            onTap: () {
                                              setState(() {
                                                countryId = _data[i].phonecode;
                                                country = _data[i].name;
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: Card(
                                              child: Container(
                                                padding: EdgeInsets.all(10),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width: width * 0.1,
                                                      child: Icon(Icons.flag,
                                                          color:
                                                              GlobalColors.blue,
                                                          size: width < 500
                                                              ? width / 32
                                                              : width / 35),
                                                    ),
                                                    Expanded(
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "${_data[i].name}",
                                                            style: GoogleFonts.ptSans(
                                                                color:
                                                                    GlobalColors
                                                                        .dark,
                                                                fontSize: width <
                                                                        500
                                                                    ? width / 33
                                                                    : width /
                                                                        35),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ))
                                    ],
                                  ),
                                );
                              }, error: (e, s) {
                                return Text(e.toString());
                              }, loading: () {
                                return Center(
                                    child:
                                        CircularProgressIndicator.adaptive());
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
                              "Country",
                              style: GoogleFonts.ptSans(
                                  color: GlobalColors.light,
                                  fontSize:
                                      width < 500 ? width / 35 : width / 35),
                            ),
                          ),
                          Container(
                            width: width * 0.6,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "   " + country!,
                              style: GoogleFonts.ptSans(
                                  color: GlobalColors.dark,
                                  fontSize:
                                      width < 500 ? width / 35 : width / 35),
                            ),
                          ),
                          Container(
                            width: width * 0.1,
                            child: Icon(
                              Icons.flag,
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
                            "State",
                            style: GoogleFonts.ptSans(
                                color: GlobalColors.light,
                                fontSize:
                                    width < 500 ? width / 35 : width / 35),
                          ),
                        ),
                        Container(
                          width: width * 0.7,
                          child: TextFormField(
                            controller: _leadStateController,
                            decoration: const InputDecoration(
                                border: InputBorder.none, hintText: "--"),
                            style: GoogleFonts.ptSans(
                                color: GlobalColors.dark,
                                fontSize:
                                    width < 500 ? width / 30 : width / 35),
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (String? value) {},
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
                            "City",
                            style: GoogleFonts.ptSans(
                                color: GlobalColors.light,
                                fontSize:
                                    width < 500 ? width / 35 : width / 35),
                          ),
                        ),
                        Container(
                          width: width * 0.7,
                          child: TextFormField(
                            controller: _leadCityController,
                            decoration: const InputDecoration(
                                border: InputBorder.none, hintText: "--"),
                            style: GoogleFonts.ptSans(
                                color: GlobalColors.dark,
                                fontSize:
                                    width < 500 ? width / 30 : width / 35),
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (String? value) {},
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
                            "Postal Code",
                            style: GoogleFonts.ptSans(
                                color: GlobalColors.light,
                                fontSize:
                                    width < 500 ? width / 35 : width / 35),
                          ),
                        ),
                        Container(
                          width: width * 0.7,
                          child: TextFormField(
                            controller: _leadPostalController,
                            decoration: const InputDecoration(
                                border: InputBorder.none, hintText: "--"),
                            style: GoogleFonts.ptSans(
                                color: GlobalColors.dark,
                                fontSize:
                                    width < 500 ? width / 30 : width / 35),
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (String? value) {},
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
                            "Address",
                            style: GoogleFonts.ptSans(
                                color: GlobalColors.light,
                                fontSize:
                                    width < 500 ? width / 35 : width / 35),
                          ),
                        ),
                        Container(
                          width: width * 0.7,
                          child: TextFormField(
                            controller: _leadAddressController,
                            decoration: const InputDecoration(
                                border: InputBorder.none, hintText: "--"),
                            style: GoogleFonts.ptSans(
                                color: GlobalColors.dark,
                                fontSize:
                                    width < 500 ? width / 30 : width / 35),
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (String? value) {},
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
                            "Note",
                            style: GoogleFonts.ptSans(
                                color: GlobalColors.light,
                                fontSize:
                                    width < 500 ? width / 35 : width / 35),
                          ),
                        ),
                        Container(
                          width: width * 0.7,
                          child: TextFormField(
                            controller: _leadNoteController,
                            decoration: const InputDecoration(
                                border: InputBorder.none, hintText: "--"),
                            style: GoogleFonts.ptSans(
                                color: GlobalColors.dark,
                                fontSize:
                                    width < 500 ? width / 30 : width / 35),
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (String? value) {},
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
                            Map<String, dynamic> data = {
                              "client_name": _leadNameController.text,
                              "company_name": _leadCompanyController.text,
                              "website": _leadWebsiteController.text,
                              "address": _leadAddressController.text,
                              "cell": _leadMobileController.text,
                              "office": "",
                              "city": _leadCityController.text,
                              "state": _leadStateController.text,
                              "country": countryId,
                              "postal_code": _leadPostalController.text,
                              "salutation": salutation.toLowerCase(),
                              "client_email": _leadEmailController.text,
                              "mobile": _leadMobileController.text,
                              "note": _leadNoteController.text,
                              "next_follow_up": followUp,
                              "agent_id": leadAgendId,
                              "source_id": sourceId,
                              "category_id": categoryId != 0 ? categoryId : "",
                              "status_id":
                                  leadStatusId != 0 ? leadStatusId : "",
                              "value": _leadValueController.text,
                            };
                            widget.onClick();
                            Api()
                                .addLead(ref.watch(tokenProvider), data)
                                .then((value) {
                              if (value.statusCode.toString() != "200") {
                                return customAlert(context, width, height,
                                    false, "Something went wrong!!!!");
                              }

                              context
                                  .pushReplacementNamed(RoutingConstants.lead);

                              customAlert(context, width, height, true,
                                  "Lead Created Successfully!");
                              Navigator.pop(context);
                              ref.refresh(leadProvider);
                              widget.onClick();
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
        ),
      ),
    );
  }
}
