import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/domain/repository/song/song_repository.dart';

import '../../../service_locator.dart';

class AddOrRemoveFavoriteSongUseCase implements UseCase<Either,String>{
  @override
  Future<Either> call({String ? params}) async{
    return await sl<SongsRepository>().addOrRemoveFavoriteSongs(params!);
  }
}