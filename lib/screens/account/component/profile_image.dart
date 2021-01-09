import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tamer_amr/providers/users_provider.dart';
import 'package:tamer_amr/screens/checked_user_login/check_user_login.dart';

class AccountProfileImage extends StatelessWidget {
  const AccountProfileImage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String userPhoto = Provider.of<Users>(context, listen: false).photo;

    return Positioned(
      top: deviceWidth * 0.06,
      left: deviceWidth * 0.34,
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          image: DecorationImage(
            fit: (userPhoto == null ||
                    userPhoto == 'https://tomeramer.tameramr.com/assets')
                ? BoxFit.fill
                : BoxFit.cover,
            image: (userPhoto == null ||
                    userPhoto == 'https://tomeramer.tameramr.com/assets')
                ? AssetImage('assets/images/user_placeholder.png')
                : NetworkImage(
                    userPhoto,
                  ),
          ),
        ),
        child: FadeInImage.assetNetwork(
          placeholder: 'assets/images/user_placeholder.png',
          image: userPhoto == 'https://tomeramer.tameramr.com/assets'
              ? 'assets/images/user_placeholder.png'
              : userPhoto,
        ),
      ),
    );
  }
}
