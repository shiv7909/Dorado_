import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class impnavi_head extends StatefulWidget {
  @override
  State<impnavi_head> createState() => _impnavibar_head();
}

class _impnavibar_head extends State<impnavi_head> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      // margin: EdgeInsets.only(top: 4),
      decoration: BoxDecoration(
       color: Color(0XFFCCEAE6),

      ),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 10, top: 5),
      height: 40,
      width: size.width,
      child: FittedBox(
        child: Text(
          'POPULAR CATEGORIES ',
          style: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.w500,
          )
              .copyWith(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 12
          ),
        ),
      ),
    );
  }
}
