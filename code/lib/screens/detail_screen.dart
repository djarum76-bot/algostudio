import 'dart:io';
import 'dart:ui' as ui;
import 'package:algostudio/components/custom_app_bar.dart';
import 'package:algostudio/cubit/image_cubit.dart';
import 'package:algostudio/models/image_model.dart';
import 'package:algostudio/models/meme_model.dart';
import 'package:algostudio/utils/app_theme.dart';
import 'package:algostudio/utils/routes.dart';
import 'package:algostudio/utils/screen_argument.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:form_validator/form_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DetailScreen extends StatefulWidget{
  const DetailScreen({super.key, required this.meme});
  final MemeModel meme;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late GlobalKey _globalKey;
  late GlobalKey<FormState> _formKey;
  late TextEditingController _text;

  bool _isText = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _globalKey = GlobalKey();
    _formKey = GlobalKey<FormState>();
    _text = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImageCubit(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar.customAppBar(context, withIcon: true, label: widget.meme.name!),
        body: _detailBody(context),
      ),
    );
  }

  Widget _detailBody(BuildContext context){
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.fromLTRB(4.w, 1.h, 4.w, 0),
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _detailImage(),
                    SizedBox(height: 2.h,),
                    _detailAction(context)
                  ],
                ),
              ),
              _detailFormText(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailImage(){
    return RepaintBoundary(
      key: _globalKey,
      child: SizedBox(
        width: double.infinity,
        height: 65.h,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CachedNetworkImage(
                height: 65.h,
                width: double.infinity,
                imageUrl: widget.meme.url!,
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
            _detailImageLogo(),
            _detailImageText()
          ],
        ),
      ),
    );
  }

  Widget _detailImageLogo(){
    return BlocBuilder<ImageCubit, ImageModel>(
      builder: (context, state){
        if(state.isLogo){
          return SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: InteractiveViewer(
              boundaryMargin: EdgeInsets.symmetric(vertical: 62.5.h, horizontal: 78.w),
              minScale: 0.1,
              maxScale: 1.6,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: FileImage(File(state.contentLogo)),
                        fit: BoxFit.contain
                    )
                ),
              ),
            ),
          );
        }else{
          return const SizedBox();
        }
      },
    );
  }

  Widget _detailImageText(){
    return BlocBuilder<ImageCubit, ImageModel>(
      builder: (context, state){
        if(state.isText){
          return SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: InteractiveViewer(
              boundaryMargin: EdgeInsets.symmetric(vertical: 62.5.h, horizontal: 78.w),
              minScale: 0.1,
              maxScale: 1.6,
              child: Text(
                state.contentText,
                style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600, color: Colors.white),
              ),
            ),
          );
        }else{
          return const SizedBox();
        }
      },
    );
  }

  Widget _detailAction(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            _detailAddLogo(context),
            SizedBox(width: 4.w,),
            _detailAddText(context),
          ],
        ),
        _detailSave(context)
      ],
    );
  }

  Widget _detailAddLogo(BuildContext context){
    return BlocBuilder<ImageCubit, ImageModel>(
      builder: (context, state){
        return GestureDetector(
          onTap: ()async{
            setState(() {
              _isText = false;
            });

            final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

            if(pickedFile != null){
              if(!mounted) return;
              context.read<ImageCubit>().changeImage(ImageModel(contentLogo: pickedFile.path, isLogo: true));
            }else{
              EasyLoading.showError("Error");
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Logo",
                style: GoogleFonts.plusJakartaSans(),
              ),
              Icon(LineIcons.image, size: 5.vmax,)
            ],
          ),
        );
      },
    );
  }

  Widget _detailAddText(BuildContext context){
    return GestureDetector(
      onTap: (){
        setState(() {
          _isText = true;
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Add Text",
            style: GoogleFonts.plusJakartaSans(),
          ),
          Icon(Icons.text_fields_rounded, size: 5.vmax,)
        ],
      ),
    );
  }

  Widget _detailSave(BuildContext context){
    return BlocBuilder<ImageCubit, ImageModel>(
      builder: (context, state){
        if(state.isText || state.isLogo){
          return GestureDetector(
            onTap: ()async{
              EasyLoading.show(status: 'Loading...');
              RenderRepaintBoundary? boundary = _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary?;
              ui.Image image = await boundary!.toImage();
              final directory = (await getApplicationDocumentsDirectory()).path;
              ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
              Uint8List pngBytes = byteData!.buffer.asUint8List();
              File imgFile = File('$directory/${DateTime.now().toIso8601String()}.jpg');
              await imgFile.writeAsBytes(pngBytes);
              EasyLoading.dismiss();

              if (!mounted) return;
              Navigator.pushNamed(
                context,
                Routes.shareScreen,
                arguments: ScreenArgument<File>(imgFile)
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Save",
                  style: GoogleFonts.plusJakartaSans(),
                ),
                Icon(Icons.save, size: 5.vmax,)
              ],
            ),
          );
        }else{
          return const SizedBox();
        }
      },
    );
  }

  Widget _detailFormText(BuildContext context){
    if(_isText){
      return Container(
        width: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.only(bottom: 1.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Form(
                key: _formKey,
                child: TextFormField(
                  controller: _text,
                  style: GoogleFonts.plusJakartaSans(),
                  validator: ValidationBuilder().build(),
                  keyboardType: TextInputType.name,
                ),
              ),
            ),
            SizedBox(width: 2.w),
            BlocBuilder<ImageCubit, ImageModel>(
              builder: (context, state){
                return GestureDetector(
                  onTap: (){
                    context.read<ImageCubit>().changeImage(ImageModel(contentText: _text.text, isText: true));
                    setState(() {
                      _isText = false;
                    });
                    _text.clear();
                  },
                  child: Text(
                    "Add",
                    style: GoogleFonts.plusJakartaSans(color: Colors.blue),
                  ),
                );
              },
            )
          ],
        ),
      );
    }else{
      return const SizedBox();
    }
  }
}