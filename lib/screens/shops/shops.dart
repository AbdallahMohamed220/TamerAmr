import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tamer_amr/models/shop_model.dart';
import 'package:tamer_amr/providers/shops_provider.dart';
import 'package:tamer_amr/screens/shops/component/shops_items.dart';
import 'package:tamer_amr/widgets/appbar.dart';
import 'package:tamer_amr/widgets/bottom_navigation_widget.dart';
import 'package:tamer_amr/widgets/floating_action_button_widget.dart';
import 'package:provider/provider.dart';
import 'package:tamer_amr/providers/users_provider.dart';

class ShopsScreen extends StatefulWidget {
  static const routeName = 'shops_screen';

  @override
  _ShopsScreenState createState() => _ShopsScreenState();
}

class _ShopsScreenState extends State<ShopsScreen> {
  bool _loadedInitData = true;
  bool _isloading = false;

  List<ShopModel> loadShopsData;

  Future<void> fechShops() async {
    setState(() {
      _isloading = true;
    });
    String accessToken = Provider.of<Users>(context, listen: false)
        .prefes
        .getString('userToken');
    Provider.of<Shops>(context, listen: false).getShops.clear();

    await Provider.of<Shops>(context, listen: false)
        .fetchShops(accessToken: accessToken);

    loadShopsData = Provider.of<Shops>(context, listen: false).getShops;
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

      fechShops().then((_) {
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
              : loadShopsData.length == 0
                  ? Center(
                      child: Text(
                        "لا توجد متاجر ",
                        style: GoogleFonts.cairo(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: loadShopsData.length,
                        itemBuilder: (context, i) => ShopsItems(
                          shopName: loadShopsData[i].name,
                          shopDescription: loadShopsData[i].description,
                          shopImage: loadShopsData[i].photo,
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
        selectedTab: 2,
        floatActionColor: Color(0xff86BED5),
        iconSelectedColor: Colors.blue,
      ),
    );
  }
}
