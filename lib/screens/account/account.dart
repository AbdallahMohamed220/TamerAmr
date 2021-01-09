import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tamer_amr/providers/users_provider.dart';
import 'package:tamer_amr/screens/account/component/account_username.dart';
import 'package:tamer_amr/screens/account/component/card_item.dart';
import 'package:tamer_amr/screens/account/component/container_item.dart';
import 'package:tamer_amr/screens/account/component/driving_license_image.dart';
import 'package:tamer_amr/screens/account/component/identity_image.dart';
import 'package:tamer_amr/screens/account/component/profile_image.dart';
import 'package:tamer_amr/widgets/appbar.dart';
import 'package:tamer_amr/widgets/bottom_navigation_widget.dart';
import 'package:tamer_amr/widgets/floating_action_button_widget.dart';

// ignore: must_be_immutable
class AccountScreen extends StatelessWidget {
  static const routeName = 'add_order_screen';
  Color _floatActionColor;

  @override
  Widget build(BuildContext context) {
    String userType = Provider.of<Users>(context, listen: false).userType;
    String photoIdentity =
        Provider.of<Users>(context, listen: false).photoIdentity;
    String photoDrivingLicense =
        Provider.of<Users>(context, listen: false).photoDrivingLicense;
    return Scaffold(
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(55.0),
        child: AppBarWidget(),
      ),
      body: ListView(
        itemExtent: MediaQuery.of(context).size.height * 1.01,
        children: [
          Stack(
            children: [
              AccountCardItem(),
              AccountContainerItem(),
              AccountUserName(),
              AccountIdentityImage(
                imageUrl: photoIdentity,
              ),
              userType == 'مندوب'
                  ? AccountDrivingLicenseImage(imageUrl: photoDrivingLicense)
                  : Container(),
              // Positioned(
              //   top: deviceWidth * 0.77,
              //   left: deviceWidth * 0.05,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       AccountCreateNewBouquet(),
              //       SizedBox(width: deviceWidth * 0.3),
              //       Container(
              //         width: deviceWidth * 0.3,
              //         height: 66,
              //         alignment: Alignment.center,
              //         decoration: BoxDecoration(
              //           color: Colors.blue,
              //           borderRadius: BorderRadius.only(
              //             topLeft: Radius.circular(15),
              //             bottomLeft: Radius.circular(15),
              //           ),
              //         ),
              //         child: Column(
              //           children: [
              //             AccountBalanceText(),
              //             AccountBalance(),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // AccountDateOfExpire(),
              //AccountParticipationRenewal(),
              //AccountAddCard(),
              AccountProfileImage(),
            ],
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButtonWidget(
        floatActionColor: Color(0xff86BED5),
      ),
      bottomNavigationBar: BottomNavigationWidget(
        selectedTab: 1,
        floatActionColor: _floatActionColor,
        iconSelectedColor: Colors.blue,
      ),
    );
  }
}
