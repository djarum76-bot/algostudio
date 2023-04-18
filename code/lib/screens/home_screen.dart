import 'package:algostudio/bloc/meme/meme_bloc.dart';
import 'package:algostudio/components/custom_app_bar.dart';
import 'package:algostudio/models/meme_model.dart';
import 'package:algostudio/utils/app_theme.dart';
import 'package:algostudio/utils/routes.dart';
import 'package:algostudio/utils/screen_argument.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<MemeBloc>(context)..add(MemesFethed()),
      child: Scaffold(
        appBar: CustomAppBar.customAppBar(context, withIcon: false, label: "Home"),
        body: _homeBody(context),
      ),
    );
  }

  Widget _homeBody(BuildContext context){
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.fromLTRB(2.w, 1.h, 2.w, 0),
        child: _homeContent(context),
      ),
    );
  }

  Widget _homeContent(BuildContext context){
    return BlocBuilder<MemeBloc, MemeState>(
      builder: (context, state){
        if(state.status == MemeStatus.loading || state.status == MemeStatus.initial){
          return const SizedBox();
        }else if(state.status == MemeStatus.error){
          return Center(
            child: Text(
              state.message ?? "Error",
              style: GoogleFonts.plusJakartaSans(),
            ),
          );
        }else{
          if(state.memes.isEmpty){
            return Center(
              child: Text(
                "No memes found",
                style: GoogleFonts.plusJakartaSans(),
              ),
            );
          }else{
            return GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 0.5.vmax,
              mainAxisSpacing: 0.5.vmax,
              physics: const BouncingScrollPhysics(),
              children: List.generate(state.memes.length, (index) {
                return _homeGridItem(context: context, meme: state.memes[index]);
              }),
            );
          }
        }
      },
    );
  }

  Widget _homeGridItem({required BuildContext context, required MemeModel meme}){
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(
          context,
          Routes.detailScreen,
          arguments: ScreenArgument<MemeModel>(meme)
        );
      },
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: CachedNetworkImage(
            height: double.infinity,
            width: double.infinity,
            imageUrl: meme.url!,
            fit: BoxFit.fill,
            placeholder: (context, url){
              return Center(
                child: LoadingAnimationWidget.prograssiveDots(
                  color: AppTheme.primaryColor,
                  size: 3.h,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}