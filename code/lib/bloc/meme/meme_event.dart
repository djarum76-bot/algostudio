part of 'meme_bloc.dart';

abstract class MemeEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class MemesFethed extends MemeEvent{}