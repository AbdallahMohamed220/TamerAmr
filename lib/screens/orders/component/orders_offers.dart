import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tamer_amr/models/offer_model.dart';
import 'package:tamer_amr/providers/users_provider.dart';
import 'package:tamer_amr/screens/order_chat/order_chat.dart';
import 'package:tamer_amr/services/db.dart';
import 'package:tamer_amr/widgets/appbar.dart';
import 'package:tamer_amr/widgets/bottom_navigation_widget.dart';
import 'package:tamer_amr/widgets/floating_action_button_widget.dart';

// ignore: must_be_immutable
class OrdersOffersScreen extends StatefulWidget {
  static const routeName = 'orders_offers_screen';
  int orderId;
  OrdersOffersScreen({this.orderId});

  @override
  _OrdersOffersScreenState createState() => _OrdersOffersScreenState();
}

class _OrdersOffersScreenState extends State<OrdersOffersScreen> {
  bool _loadedInitData = true;
  bool _isloading = false;

  List<OfferModel> loadofferData;

  Future<void> fechOffer() async {
    setState(() {
      _isloading = true;
    });
    String accessToken = Provider.of<Users>(context, listen: false)
        .prefes
        .getString('userToken');
    Provider.of<Users>(context, listen: false).getOffer.clear();

    await Provider.of<Users>(context, listen: false)
        .fetchDelveriyOffer(accessToken: accessToken, orderid: widget.orderId);

    loadofferData = Provider.of<Users>(context, listen: false).getOffer;
    print(loadofferData.length);
    setState(() {
      _isloading = false;
    });
  }

  @override
  void didChangeDependencies() async {
    if (_loadedInitData) {
      setState(() {
        _isloading = true;
      });

      fechOffer().then((_) {
        setState(() {
          _isloading = false;
        });
      });
    }

    _loadedInitData = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55.0),
        child: AppBarWidget(),
      ),
      body: Column(
        children: [
          _isloading
              ? Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Theme.of(context).hoverColor,
                    ),
                  ),
                )
              : loadofferData.length == 0
                  ? Center(
                      child: Text(
                        "لا توجد عروض ",
                        style: GoogleFonts.cairo(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: loadofferData.length,
                        itemBuilder: (context, i) => OrderOffersItems(
                          id: loadofferData[i].id,
                          name: loadofferData[i].name,
                          delveryOrderemail: loadofferData[i].email,
                          photo: loadofferData[i].photo,
                          createdAt: loadofferData[i].createdAt,
                          points: loadofferData[i].points,
                          price: loadofferData[i].price,
                        ),
                      ),
                    ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButtonWidget(
        floatActionColor: Color(0xff86BED5),
      ),
      bottomNavigationBar: BottomNavigationWidget(
        floatActionColor: Color(0xff86BED5),
        iconSelectedColor: Colors.blue,
      ),
    );
  }
}

// ignore: must_be_immutable
class OrderOffersItems extends StatelessWidget {
  int id;
  String name;
  String photo;
  int price;
  int points;
  String createdAt;
  String delveryOrderemail;
  OrderOffersItems({
    this.id,
    this.name,
    this.points,
    this.photo,
    this.createdAt,
    this.price,
    this.delveryOrderemail,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, left: 8, top: 10, bottom: 25),
      child: InkWell(
        onTap: () async {
          // String loginUseremail =
          //     Provider.of<Users>(context, listen: false).loginUseremail;

          // List<String> users = [loginUseremail, delveryOrderemail];
          // String chatRoomId = Provider.of<Users>(context, listen: false).uid;

          // Map<String, dynamic> chatRoom = {
          //   "users": users,
          //   "chatRoomId": chatRoomId,
          // };

          // await DBService.instance.addChatRoom(
          //     senderId: 'CuhWjQQKxfXXPSz3TPNZITiwPn53',
          //     receiveId: 'f11SRYgbCvYtd9WBPENemRpU53l2',
          //     message: 'Hi from there4');
          // await DBService.instance.getChats();

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => OrdersChatScreen(
                id: id,
                name: name,
                photo: photo,
                price: price,
                points: points,
                createdAt: createdAt,
              ),
            ),
          );
        },
        child: Material(
          elevation: 2,
          color: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            height: 130,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Row(
                children: [
                  Container(
                    width: 90.0,
                    height: 90.0,
                    margin: EdgeInsets.only(right: 15),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          photo,
                        ),
                      ),
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          name,
                          style: GoogleFonts.cairo(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                ),
                                child: Image.asset(
                                  'assets/icons/time-left.png',
                                  width: 15,
                                  height: 15,
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                              Text(
                                createdAt,
                                style: GoogleFonts.cairo(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 80,
                          height: 25,
                          child: RatingBar.builder(
                            initialRating: points.toDouble(),
                            minRating: points.toDouble(),
                            direction: Axis.horizontal,
                            itemSize: 15,
                            allowHalfRating: false,
                            ignoreGestures: true,
                            textDirection: TextDirection.ltr,
                            itemCount: 5,
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      '${price.toString()} ريال',
                      style: GoogleFonts.cairo(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: Colors.orangeAccent,
                      ),
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
