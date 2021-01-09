import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationItems extends StatelessWidget {
  const NotificationItems({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: ListTile(
              leading: SizedBox(
                height: 25,
                width: 25,
                child: Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/icons/bin.png'))),
                    ),
                  ),
                ),
              ),
              title: Text(
                'نص رئيسى',
                style: GoogleFonts.cairo(
                  fontSize: 23,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              subtitle: Text(
                'نص فرعى  نص فرعى نص فرعى نص فرعى نص فرعى نص فرعى نص فرعى نص فرعى  نص فرعى  نص فرعى نص فرعى',
                style: GoogleFonts.cairo(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColor.withOpacity(0.5),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
