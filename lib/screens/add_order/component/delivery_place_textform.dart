import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class AddOrderDeliveryPlaceTextForm extends StatelessWidget {
  // TextEditingController orderRecipptController = TextEditingController();
  String orderRecipptController;
  AddOrderDeliveryPlaceTextForm({this.orderRecipptController});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextFormField(
          // controller: orderRecipptController,
          initialValue: orderRecipptController,

          textCapitalization: TextCapitalization.none,
          enableSuggestions: false,
          style: GoogleFonts.cairo(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.orange,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(right: 10, top: 15, bottom: 10),
            hintText: ' يرجى اختيار مكان إستلام الطلب من الخريطة',
            hintStyle: GoogleFonts.cairo(
              fontSize: 19,
              fontWeight: FontWeight.w600,
              color: Colors.orange,
            ),
            filled: true,
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[300]),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[300], width: 1),
              borderRadius: BorderRadius.circular(10.0),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.grey[300], width: 1),
            ),
          ),
          validator: (val) {
            if (val.trim().isEmpty) {
              return "مكان الوصول غير صالح";
            } else if (val.trim() == 'مكان إستلام الطلب') {
              return "مكان الوصول غير صالح";
            } else {
              return null;
            }
          },
        ),
      ),
    );
  }
}
