import 'dart:io';
import 'package:algostudio/components/custom_app_bar.dart';
import 'package:algostudio/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:share_plus/share_plus.dart';

class ShareScreen extends StatelessWidget{
  const ShareScreen({super.key, required this.file});
  final File file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.customAppBar(context, withIcon: true, label: "Share"),
      body: _shareBody(context),
    );
  }

  Widget _shareBody(BuildContext context){
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.fromLTRB(4.w, 1.h, 4.w, 0),
        child: Column(
          children: [
            _shareImage(),
            SizedBox(height: 2.h,),
            _shareSocialMedia(),
          ],
        ),
      ),
    );
  }

  Widget _shareImage(){
    return Container(
      width: double.infinity,
      height: 65.h,
      decoration: BoxDecoration(
        image: DecorationImage(image: FileImage(file), fit: BoxFit.cover)
      ),
    );
  }

  Widget _shareSocialMedia(){
    return SizedBox(
      width: double.infinity,
      height: 5.5.h,
      child: ElevatedButton(
        style: AppTheme.elevatedButton(20, AppTheme.primaryColor),
        onPressed: (){
          Share.shareXFiles([XFile(file.path)]);
        },
        child: Text(
          "Share to Social Media",
          style: GoogleFonts.plusJakartaSans(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16.sp),
        ),
      ),
    );
  }
}