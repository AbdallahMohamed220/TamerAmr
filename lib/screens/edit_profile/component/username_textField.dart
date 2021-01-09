import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class UserNameTextField extends StatelessWidget {
  String hintText;
  TextEditingController controller = TextEditingController();
  String username;
  Color color = Colors.black;
  UserNameTextField(
      {this.hintText, this.username, this.color, this.controller});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: TextFormField(
          textCapitalization: TextCapitalization.none,
          enableSuggestions: false,
          controller: TextEditingController()..text = username,
          validator: (val) {
            if (val.trim().isEmpty) {
              return "القيمة غير صالحة";
            } else if (val.trim().length < 6) {
              return "القيمة غير صالحة";
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.orange.withOpacity(0.03),
            contentPadding: EdgeInsets.only(right: 10, top: 8),
            hintText: hintText,
            hintStyle: GoogleFonts.cairo(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[400],
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[300], width: 1),
              borderRadius: BorderRadius.circular(15.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(15.0),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(color: Colors.grey[300], width: 1),
            ),
          ),
        ),
      ),
    );
  }
}
