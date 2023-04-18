import 'dart:io';

import 'package:algostudio/models/meme_model.dart';
import 'package:algostudio/screens/detail_screen.dart';
import 'package:algostudio/screens/home_screen.dart';
import 'package:algostudio/screens/share_screen.dart';
import 'package:algostudio/utils/screen_argument.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Routes{
  static const homeScreen = '/home';
  static const detailScreen = '/detail';
  static const shareScreen = '/share';

  static Route<dynamic>? onGenerateRoutes(RouteSettings settings){
    switch(settings.name){
      case homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case detailScreen:
        final args = settings.arguments as ScreenArgument<MemeModel>;
        return MaterialPageRoute(builder: (_) => DetailScreen(meme: args.data));
      case shareScreen:
        final args = settings.arguments as ScreenArgument<File>;
        return MaterialPageRoute(builder: (_) => ShareScreen(file: args.data));
      default:
        return MaterialPageRoute(builder: (_){
          return Scaffold(
            body: Center(
              child: Text(
                "No route defined for ${settings.name}",
                style: GoogleFonts.plusJakartaSans(),
              ),
            ),
          );
        });
    }
  }
}