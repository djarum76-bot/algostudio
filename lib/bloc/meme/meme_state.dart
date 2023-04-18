part of 'meme_bloc.dart';

enum MemeStatus { initial, loading, error, getList, getDetail }

class MemeState extends Equatable{
  const MemeState({
    this.status = MemeStatus.initial,
    this.memes = const <MemeModel>[],
    this.meme,
    this.message,
  });

  final MemeStatus status;
  final List<MemeModel> memes;
  final MemeModel? meme;
  final String? message;

  @override
  List<Object?> get props => [status, memes, meme, message];

  MemeState copyWith({
    MemeStatus? status,
    List<MemeModel>? memes,
    MemeModel? meme,
    String? message
  }) {
    return MemeState(
      status: status ?? this.status,
      memes: memes ?? this.memes,
      meme: meme ?? this.meme,
      message: message ?? this.message,
    );
  }
}