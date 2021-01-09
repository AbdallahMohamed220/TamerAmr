import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class ShopsItems extends StatelessWidget {
  String shopName;
  String shopDescription;
  String shopImage;
  ShopsItems({
    this.shopDescription,
    this.shopImage,
    this.shopName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 7,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(shopImage),
            ),
            title: Text(
              shopName,
              style: GoogleFonts.cairo(
                fontSize: 23,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            subtitle: Text(
              shopDescription,
              style: GoogleFonts.cairo(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
