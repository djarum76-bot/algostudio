import 'package:algostudio/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomAppBar{
  static AppBar customAppBar(BuildContext context, {required bool withIcon, required String label}){
    if(withIcon){
      return AppBar(
        title: Text(
          label,
          style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700, fontSize: 18.sp, color: Colors.black),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(LineIcons.angleLeft, color: Colors.black),
        ),
        backgroundColor: AppTheme.scaffoldColor,
        elevation: 0,
      );
    }else{
      return AppBar(
        title: Text(
          label,
          style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700, fontSize: 18.sp, color: Colors.black),
        ),
        backgroundColor: AppTheme.scaffoldColor,
        elevation: 0,
        centerTitle: true,
      );
    }
  }
}