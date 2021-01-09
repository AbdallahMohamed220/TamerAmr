import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tamer_amr/models/order_model.dart';
import 'package:tamer_amr/providers/orders_provider.dart';
import 'package:tamer_amr/screens/orders/component/orders_items.dart';
import 'package:tamer_amr/screens/orders/component/type_of_orders.dart';
import 'package:tamer_amr/screens/checked_user_login/check_user_login.dart';
import 'package:tamer_amr/widgets/appbar.dart';
import 'package:tamer_amr/widgets/bottom_navigation_widget.dart';
import 'package:tamer_amr/widgets/floating_action_button_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = 'orders_screen';

  const OrdersScreen({Key key}) : super(key: key);

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool _loadedInitData = true;
  bool _isloading = true;

  List<OrderModel> ordersList;
  SharedPreferences logindata;
  String userToken;

  Future<void> _getCompletedOrders() async {
    setState(() {
      _isloading = true;
    });
    Provider.of<Orders>(context, listen: false).getOrders.clear();
    await Provider.of<Orders>(context, listen: false)
        .getCompletedOrders(accessToken: userToken);
    ordersList = Provider.of<Orders>(context, listen: false).getOrders;

    setState(() {
      _isloading = false;
    });
  }

  Future<void> _getNotcompletedOrders() async {
    setState(() {
      _isloading = true;
    });

    Provider.of<Orders>(context, listen: false).getOrders.clear();
    await Provider.of<Orders>(context, listen: false)
        .getNotCompletedOrders(accessToken: userToken);
    ordersList = Provider.of<Orders>(context, listen: false).getOrders;
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
      logindata = await SharedPreferences.getInstance();
      userToken = logindata.getString('userToken');

      _getNotcompletedOrders().then((_) {
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
          Container(
            width: deviceWidth,
            height: deviceWidth * 0.19,
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TypeOfOrdersScreen(
                          onTap: () => _getCompletedOrders(),
                          typeOfOrder: 'الطلبات المكتملة',
                          completed: true,
                        ),
                        SizedBox(width: 5),
                        TypeOfOrdersScreen(
                          onTap: () => _getNotcompletedOrders(),
                          typeOfOrder: 'الطلبات الحالية',
                          completed: false,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          _isloading
              ? Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Theme.of(context).hoverColor,
                  ),
                )
              : ordersList.length == 0
                  ? Center(
                      child: Text(
                      "لا توجد طلبات ",
                      style: GoogleFonts.cairo(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColor,
                      ),
                    ))
                  : Expanded(
                      child: ListView.builder(
                        itemCount: ordersList.length,
                        itemBuilder: (context, i) => OrdersItems(
                          imageUrl: ordersList[i].photo,
                          orderDate: ordersList[i].createdAt,
                          orderId: ordersList[i].id,
                          ordername: ordersList[i].name,
                          ordernameDescription: ordersList[i].description,
                          orderprice: ordersList[i].priceTo,
                          reverse: ordersList[i].id.isOdd ? false : true,
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
        selectedTab: 3,
        floatActionColor: Color(0xff86BED5),
        iconSelectedColor: Colors.blue,
      ),
    );
  }
}
