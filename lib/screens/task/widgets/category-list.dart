import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../const/const.dart';
import '../../../models/categoryModel.dart';

class CategoryList extends StatefulWidget {
  final List<CategoryModel> getcategoryList;
  final Function onclick;
  const CategoryList(
      {Key? key, required this.getcategoryList, required this.onclick})
      : super(key: key);

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  List<CategoryModel> categoryList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      categoryList = widget.getcategoryList;
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
                    categoryList = widget.getcategoryList;
                  });
                setState(() {
                  categoryList = [];
                });

                for (var i = 0; i < widget.getcategoryList.length; i++) {
                  if (widget.getcategoryList[i].categoryName!
                      .toLowerCase()
                      .startsWith(value.toLowerCase().trim())) {
                    setState(() {
                      categoryList.add(widget.getcategoryList[i]);
                    });
                  }
                }
              },
              decoration: InputDecoration(
                hintText: "Search by category",
                hintStyle: GoogleFonts.ptSans(
                    color: GlobalColors.light,
                    fontSize: width < 500 ? width / 40 : width / 35),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 0.4, color: GlobalColors.light)
                    //<-- SEE HERE
                    ),
              ),
            ),
            for (var i = 0; i < categoryList.length; i++)
              InkWell(
                  onTap: () {
                    widget.onclick(categoryList[i]);
                  },
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Container(
                            width: width * 0.1,
                            child: Icon(Icons.category,
                                color: GlobalColors.blue,
                                size: width < 500 ? width / 32 : width / 35),
                          ),
                          Expanded(
                            child: Text(
                              "${categoryList[i].categoryName}",
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
      ),
    );
  }
}
