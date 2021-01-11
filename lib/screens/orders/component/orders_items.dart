import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tamer_amr/screens/orders/component/order_description.dart';
import 'package:tamer_amr/screens/checked_user_login/check_user_login.dart';

// ignore: must_be_immutable
class OrdersItems extends StatelessWidget {
  bool reverse;
  String imageUrl;
  String ordername;
  String ordernameDescription;
  int orderId;
  int orderprice;
  String orderDate;
  OrdersItems({
    this.reverse,
    this.imageUrl,
    this.ordername,
    this.ordernameDescription,
    this.orderId,
    this.orderprice,
    this.orderDate,
  });

  @override
  Widget build(BuildContext context) {
    // DateTime dateTimeCreatedAt =
    //     DateTime.parse(orderDate.toString().substring(0, 10));
    // DateTime dateTimeNow = DateTime.now();
    // final differenceInDays = dateTimeNow.difference(dateTimeCreatedAt).inDays;
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 20),
      child: Align(
        alignment: reverse ? Alignment.topRight : Alignment.topLeft,
        child: InkWell(
          onTap: () {
            print(orderId);

            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => OrdersDescriptionScreen(
                  orderId: orderId,
                ),
              ),
            );
          },
          child: Container(
            child: Stack(
              children: [
                Container(
                  width: deviceWidth * 0.85,
                  height: deviceWidth * 0.4,
                  decoration: reverse
                      ? BoxDecoration(
                          color: Color(0xffE1E1E1),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            topLeft: Radius.circular(20),
                          ),
                        )
                      : BoxDecoration(
                          color: Color(0xffE1E1E1),
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 80.0,
                      right: 8,
                      left: 15,
                    ),
                    child: Container(
                      width: deviceWidth * 0.8,
                      padding: const EdgeInsets.only(
                        top: 5,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            width: 80,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text("0"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Image.asset(
                                    'assets/icons/mark.jpg',
                                    width: 23,
                                    height: 23,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: 130,
                                      height: 30,
                                      margin: EdgeInsets.only(top: 3),
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: Text(
                                          ordername,
                                          style: GoogleFonts.cairo(
                                            fontSize: 19,
                                            fontWeight: FontWeight.w600,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: Container(
                                        width: 190,
                                        height: 60,
                                        child: Text(
                                          ordernameDescription,
                                          style: GoogleFonts.cairo(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 5.0, left: 10),
                                      child: Container(
                                        width: 70,
                                        height: 65,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            25,
                                          ),
                                          image: DecorationImage(
                                            image: NetworkImage(imageUrl),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      orderId.toString(),
                                      style: GoogleFonts.cairo(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: deviceWidth * 0.85,
                  height: deviceWidth * 0.15,
                  decoration: reverse
                      ? BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            topLeft: Radius.circular(20),
                          ),
                        )
                      : BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text(
                                "ميزانية التوصيل $orderprice ريال",
                                style: GoogleFonts.cairo(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Text(
                              orderDate,
                              style: GoogleFonts.cairo(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 10,
                                left: 5,
                              ),
                              child: Image.asset(
                                'assets/icons/time-left.png',
                                width: 20,
                                height: 20,
                                color: Theme.of(context).accentColor,
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
        ),
      ),
    );
  }
}
