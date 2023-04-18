import 'package:algostudio/bloc/meme/meme_bloc.dart';
import 'package:algostudio/repositories/meme_repository.dart';
import 'package:algostudio/utils/app_theme.dart';
import 'package:algostudio/utils/list_view_behavior.dart';
import 'package:algostudio/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark
        )
    );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return RepositoryProvider(
      create: (context) => MemeRepository(),
      child: BlocProvider(
        create: (context) => MemeBloc(memeRepository: RepositoryProvider.of<MemeRepository>(context)),
        child: ResponsiveSizer(
          builder: (context, orientation, screenType){
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: AppTheme.theme(),
              builder: EasyLoading.init(builder: (context, child){
                return ScrollConfiguration(
                  behavior: ListViewBehavior(),
                  child: child!,
                );
              }),
              onGenerateRoute: Routes.onGenerateRoutes,
              initialRoute: Routes.homeScreen,
            );
          },
        ),
      ),
    );
  }
}