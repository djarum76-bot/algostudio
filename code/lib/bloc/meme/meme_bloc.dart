import 'package:algostudio/models/meme_model.dart';
import 'package:algostudio/repositories/meme_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'meme_event.dart';
part 'meme_state.dart';

class MemeBloc extends Bloc<MemeEvent, MemeState> {
  final MemeRepository memeRepository;

  MemeBloc({required this.memeRepository}) : super(const MemeState()) {
    on<MemesFethed>(_onMemesFetched);
  }

  Future<void> _onMemesFetched(MemesFethed event, Emitter<MemeState> emit)async{
    emit(state.copyWith(status: MemeStatus.loading));

    final apiResponse = await memeRepository.getListMeme();

    if(apiResponse.success){
      emit(state.copyWith(
        status: MemeStatus.getList,
        memes: apiResponse.data
      ));
    }else{
      emit(state.copyWith(
        status: MemeStatus.error,
        message: apiResponse.message
      ));
    }
  }
}
