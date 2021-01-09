import 'package:provider/provider.dart';
import 'package:tamer_amr/providers/orders_provider.dart';
import 'package:tamer_amr/providers/shops_provider.dart';
import 'package:tamer_amr/providers/users_provider.dart';
import 'package:tamer_amr/screens/about_us/about_us.dart';
import 'package:tamer_amr/screens/add_order/add-order.dart';
import 'package:tamer_amr/screens/app_idea/app_idea.dart';
import 'package:tamer_amr/screens/check_user_type/check_user_type.dart';
import 'package:tamer_amr/screens/checked_user_login/check_user_login.dart';
import 'package:tamer_amr/screens/contact_us/contact_us.dart';
import 'package:tamer_amr/screens/home/home.dart';
import 'package:tamer_amr/screens/home_partnership/home_partnership.dart';
import 'package:tamer_amr/screens/intro/intro.dart';
import 'package:tamer_amr/screens/login/login.dart';
import 'package:tamer_amr/screens/messages/messages.dart';
import 'package:tamer_amr/screens/notification/notification.dart';
import 'package:tamer_amr/screens/orders/component/order_description.dart';
import 'package:tamer_amr/screens/orders/component/orders_offers.dart';
import 'package:tamer_amr/screens/edit_profile/edit_profile.dart';
import 'package:tamer_amr/screens/orders/orders.dart';
import 'package:tamer_amr/screens/register/register.dart';
import 'package:tamer_amr/screens/splash/splash.dart';
import 'package:tamer_amr/screens/terms_of_use/terms_of_use.dart';
import 'package:tamer_amr/screens/choose_type_of_account/choose_type_of_account.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:tamer_amr/screens/upload_user_images/upload_user_images.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Users(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        ),
        ChangeNotifierProvider.value(
          value: Shops(),
        ),
      ],
      child: MaterialApp(
        builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget),
          maxWidth: 1200,
          minWidth: 450,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(450, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],
        ),
        debugShowCheckedModeBanner: false,
        title: 'TamerAmr',
        theme: ThemeData(
          primaryColor: Colors.black,
          accentColor: Colors.white,
          hoverColor: Colors.grey,
        ),
        home: CheckUserLogin(),
        routes: {
          CheckUserLogin.routeName: (context) => CheckUserLogin(),
          SplashScreen.routeName: (context) => SplashScreen(),
          IntroScreen.routeName: (context) => IntroScreen(),
          TermsOfUseScreen.routeName: (context) => TermsOfUseScreen(),
          LoginScreen.routeName: (context) => LoginScreen(),
          RegisterScreen.routeName: (context) => RegisterScreen(),
          CheckUserTypeScreen.routeName: (context) => CheckUserTypeScreen(),
          EditProfileScreen.routeName: (context) => EditProfileScreen(),
          MessagesScreen.routeName: (context) => MessagesScreen(),
          NotificationScreen.routeName: (context) => NotificationScreen(),
          HomeScreen.routeName: (context) => HomeScreen(),
          HomePartnerShipScreen.routeName: (context) => HomePartnerShipScreen(),
          AddOrderScreen.routeName: (context) => AddOrderScreen(),
          OrdersScreen.routeName: (context) => OrdersScreen(),
          ChooseTypeOfAccountScreen.routeName: (context) =>
              ChooseTypeOfAccountScreen(),
          UpLoadUserImagesScreen.routeName: (context) =>
              UpLoadUserImagesScreen(),
          OrdersDescriptionScreen.routeName: (context) =>
              OrdersDescriptionScreen(),
          OrdersOffersScreen.routeName: (context) => OrdersOffersScreen(),
          ContactUsScreen.routeName: (context) => ContactUsScreen(),
          AppIdeaScreen.routeName: (context) => AppIdeaScreen(),
          AboutUsScreen.routeName: (context) => AboutUsScreen(),
        },
      ),
    );
  }
}
