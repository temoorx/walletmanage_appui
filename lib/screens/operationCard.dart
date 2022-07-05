import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/color_constant.dart';

class OperationCard extends StatefulWidget {
  final String operation;
  final String selectedIcon;
  final String unSelectedIcon;
  final bool isSelected;

  // _HomeScreenState context;

  OperationCard({this.operation, this.selectedIcon, this.unSelectedIcon, this.isSelected});
  _OperationCardState createState() => _OperationCardState();
}

class _OperationCardState extends State<OperationCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      width: 123,
      height: 123,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: kTenBlackColor,
            blurRadius: 10,
            spreadRadius: 5,
            offset: Offset(8.0, 8.0),
          )
        ],
        borderRadius: BorderRadius.circular(15),
        color: widget.isSelected ? kBlueColor : kWhiteColor,
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
        SvgPicture.asset(widget.isSelected ? widget.selectedIcon : widget.unSelectedIcon),
        SizedBox(height: 9),
        Text(widget.operation, textAlign: TextAlign.center, style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: widget.isSelected ? kWhiteColor : kBlueColor))
      ]),
    );
  }
}
