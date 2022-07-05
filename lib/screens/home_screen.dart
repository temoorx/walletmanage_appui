import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttermoneymanagementapp/models/card_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/color_constant.dart';
import '../models/operation_model.dart';
import '../models/transaction_model.dart';
import 'operationCard.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int current = 0;
//Handle Indicator
  List<T> map<T>(List list, Function handler) {
    //Current Selected

    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 8),
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 16, right: 16, top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                      onTap: () {
                        print('Drawer Tapped');
                      },
                      child: SvgPicture.asset('assets/svg/drawer_icon.svg')),
                  Container(
                    height: 59,
                    width: 59,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), image: DecorationImage(image: AssetImage('assets/images/user_image.png'))),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                Text('Good Morning', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w500, color: kBlackColor)),
                Text('Amanda Alex', style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w700, color: kBlackColor)),
              ]),
            ),
            Container(
                height: 199,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(left: 16, right: 6),
                    itemCount: cards.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(right: 8),
                        height: 199,
                        width: 349,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28),
                          color: Color(
                            cards[index].cardBackground,
                          ),
                        ),
                        child: Stack(
                          children: <Widget>[
                            Positioned(child: SvgPicture.asset(cards[index].cardElementTop)),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: SvgPicture.asset(cards[index].cardElementBottom),
                            ),
                            Positioned(
                                left: 29,
                                top: 48,
                                child: Text('CARD NUMBER',
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: kWhiteColor,
                                    ))),
                            Positioned(
                                left: 29,
                                top: 65,
                                child: Text(cards[index].cardNumber,
                                    style: GoogleFonts.inter(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: kWhiteColor,
                                    ))),
                            Positioned(
                                right: 21,
                                top: 35,
                                child: Image.asset(
                                  cards[index].cardType,
                                  width: 27,
                                  height: 27,
                                )),
                            Positioned(left: 29, bottom: 45, child: Text('CARD HOLDER', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400, color: kWhiteColor))),
                            Positioned(left: 29, bottom: 21, child: Text(cards[index].user, style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w700, color: kWhiteColor))),
                            Positioned(left: 202, bottom: 45, child: Text('EXPIRY DATE', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400, color: kWhiteColor))),
                            Positioned(left: 202, bottom: 21, child: Text(cards[index].cardExpired, style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w700, color: kWhiteColor)))
                          ],
                        ),
                      );
                    })),
            //Operation Section
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 13, top: 29, right: 10),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                Text(
                  'Operations',
                  style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: kBlackColor),
                ),
                Row(
                  children: map<Widget>(datas, (index, selected) {
                    return Container(alignment: Alignment.centerLeft, height: 9, width: 9, margin: EdgeInsets.only(right: 6), decoration: BoxDecoration(shape: BoxShape.circle, color: current == index ? kBlueColor : kTwentyBlueColor));
                  }),
                ),
              ]),
            ),
            Container(
              height: 123,
              child: ListView.builder(
                  itemCount: datas.length,
                  padding: EdgeInsets.only(left: 16),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          current = index;
                        });
                      },
                      child: OperationCard(operation: datas[index].name, selectedIcon: datas[index].selectedIcon, unSelectedIcon: datas[index].unselectedIcon, isSelected: current == index),
                    );
                  }),
            ),
            //Transaction Section
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 13, top: 29, right: 10),
              child: Text(
                'Transaction History',
                style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: kBlackColor),
              ),
            ),
            ListView.builder(
              itemCount: transactions.length,
              padding: EdgeInsets.only(left: 16, right: 16),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  height: 76,
                  margin: EdgeInsets.only(bottom: 13),
                  padding: EdgeInsets.fromLTRB(24, 12, 12, 22),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: kWhiteColor, boxShadow: [
                    BoxShadow(
                      color: kTenBlackColor,
                      blurRadius: 10,
                      spreadRadius: 5,
                      offset: Offset(8.0, 8.0),
                    )
                  ]),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                    Row(children: <Widget>[
                      Container(height: 57, width: 57, decoration: BoxDecoration(shape: BoxShape.circle, image: DecorationImage(image: AssetImage(transactions[index].photo)))),
                      SizedBox(width: 13),
                      Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                        Text(transactions[index].name, style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: kBlackColor)),
                        Text(transactions[index].date, style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w400, color: kGreyColor))
                      ])
                    ]),
                    Row(
                      children: <Widget>[
                        Text(transactions[index].amount, style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: kBlueColor))
                      ],
                    )
                  ]),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
