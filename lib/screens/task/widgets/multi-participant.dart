import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../const/const.dart';
import '../../../provider/providers.dart';

class MultiSelectParticipant extends ConsumerStatefulWidget {
  final List<Map<String, dynamic>> selectedMember;
  final Function onClick;

  MultiSelectParticipant({
    Key? key,
    required this.onClick,
    required this.selectedMember,
  }) : super(key: key);

  @override
  _MultiSelectParticipantState createState() => _MultiSelectParticipantState();
}

class _MultiSelectParticipantState
    extends ConsumerState<MultiSelectParticipant> {
  List<String?> members = [];

  @override
  void initState() {
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
    final memberData = ref.watch(employeProvider);

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
            height: height * 0.9,
            width: width,
            child: memberData.when(data: (_data) {
              return Column(
                children: [
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
                  Container(
                    height: height * 0.68,
                    width: width,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          for (var i = 0; i < _data.length; i++)
                            InkWell(
                              onTap: () {
                                widget.onClick({
                                  "name": _data[i].name,
                                  "id": _data[i].id,
                                  "image": _data[i].imageUrl,
                                });
                                if (members.isEmpty) {
                                  return setState(() {
                                    members.add(_data[i].imageUrl);
                                  });
                                }
                                if (members.contains(_data[i].imageUrl)) {
                                  return setState(() {
                                    members.remove(_data[i].imageUrl);
                                  });
                                } else {
                                  return setState(() {
                                    members.add(_data[i].imageUrl);
                                  });
                                }
                              },
                              child: Card(
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      Container(
                                          width: width * 0.1,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: Image.network(
                                              _data[i].imageUrl!,
                                              width: 20,
                                            ),
                                          )),
                                      Expanded(
                                        child: Text(
                                          "${_data[i].name}",
                                          style: GoogleFonts.josefinSans(
                                              color: GlobalColors.dark,
                                              fontSize: width < 500
                                                  ? width / 33
                                                  : width / 35),
                                        ),
                                      ),
                                      if (members.contains(_data[i].imageUrl))
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
              );
            }, error: (e, s) {
              return Text(e.toString());
            }, loading: () {
              return Center(child: CircularProgressIndicator.adaptive());
            }),
          ),
        ));
  }
}
