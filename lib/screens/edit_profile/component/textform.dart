import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class TextFormWidget extends StatelessWidget {
  String hintText;
  TextEditingController controller = TextEditingController();

  Color color = Colors.black;
  TextFormWidget({this.hintText, this.color, this.controller});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: TextFormField(
          textCapitalization: TextCapitalization.none,
          enableSuggestions: false,
          controller: controller,
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
    //     Padding(
    //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
    //   child: Stack(
    //     children: [
    //       Container(
    //         height: 65,
    //         decoration: BoxDecoration(
    //           borderRadius: BorderRadius.all(
    //             Radius.circular(15),
    //           ),
    //           boxShadow: [
    //             BoxShadow(
    //               color: Colors.grey[400].withOpacity(0.1),
    //               blurRadius: 4,
    //               spreadRadius: 4,
    //               offset: Offset(0.5, 0),
    //             ),
    //           ],
    //         ),
    //       ),
    //       Directionality(
    //         textDirection: TextDirection.rtl,
    //         child: Container(
    //           height: 55,
    //           decoration: BoxDecoration(
    //             borderRadius: BorderRadius.all(
    //               Radius.circular(10),
    //             ),
    //           ),
    //           child: Material(
    //             elevation: 2,
    //             borderRadius: BorderRadius.all(
    //               Radius.circular(15),
    //             ),
    //             shadowColor: Colors.grey.withOpacity(0.3),
    //             child: TextFormField(
    //               controller: controller,
    //               decoration: InputDecoration(
    //                 filled: true,
    //                 fillColor: Colors.orange.withOpacity(0.045),
    //                 hintText: hintText,
    //                 hintStyle: GoogleFonts.cairo(
    //                   fontSize: 18,
    //                   fontWeight: FontWeight.w600,
    //                   color: Colors.grey[400],
    //                 ),
    //                 border: OutlineInputBorder(
    //                   borderRadius: BorderRadius.all(
    //                     Radius.circular(10),
    //                   ),
    //                 ),
    //                 enabledBorder: OutlineInputBorder(
    //                   borderSide: BorderSide(
    //                     color: Colors.grey[400],
    //                     width: 1.5,
    //                   ),
    //                   borderRadius: BorderRadius.circular(15.0),
    //                 ),
    //                 focusedBorder: OutlineInputBorder(
    //                   borderSide:
    //                       BorderSide(color: Colors.grey[400], width: 1.5),
    //                   borderRadius: BorderRadius.circular(15.0),
    //                 ),
    //               ),
    //               validator: (val) {
    //                 if (val.trim().isEmpty) {
    //                   return "القيمة غير صالحة";
    //                 } else if (val.trim().length < 6) {
    //                   return "القيمة غير صالحة";
    //                 } else {
    //                   return null;
    //                 }
    //               },
    //             ),
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
