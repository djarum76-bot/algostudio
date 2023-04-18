import 'package:algostudio/models/image_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImageCubit extends Cubit<ImageModel>{
  ImageCubit() : super(ImageModel());

  void changeImage(ImageModel value){
    emit(value);
  }
}