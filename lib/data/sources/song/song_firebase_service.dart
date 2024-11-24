import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:spotify/data/models/Song/song.dart';
import 'package:spotify/domain/entities/song/song.dart';

abstract class SongFirebaseService{
  Future<Either> getNewsSongs();
}

class SongFirebaseServiceImpl extends SongFirebaseService{
  @override
  Future<Either> getNewsSongs() async{
    try {
      List<SongEntity> songs = [];
      var data = await FirebaseFirestore.instance.collection("Songs")
          .orderBy("releaseDate", descending: true)
          .limit(100)
          .get();
      for (var elem in data.docs) {
        var song = SongModel.fromJson(elem.data());
        //Convierte el modelo a una entidad
        songs.add(song.toEntity());
      }
      return Right(songs);
    }catch(e){
      return left("An error occurred, Please try again. $e");
    }
  }

}