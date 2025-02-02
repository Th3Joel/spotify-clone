import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify/data/models/Song/song.dart';
import 'package:spotify/domain/entities/song/song.dart';
import 'package:spotify/domain/usecases/song/is_favorite_song.dart';

import '../../../service_locator.dart';

abstract class SongFirebaseService{
  Future<Either> getNewsSongs();
  Future<Either> getPlayList();
  Future<Either> addOrRemoveFavoriteSong(String songId);
  Future<bool> isFavorite(String songId);
  Future<Either> getUserFavoriteSongs();

}

class SongFirebaseServiceImpl extends SongFirebaseService{
  @override
  Future<Either> getNewsSongs() async{
    try {
      List<SongEntity> songs = [];
      var data = await FirebaseFirestore.instance.collection("Songs")
          .orderBy("releaseDate", descending: true)
          .limit(3)
          .get();
      for (var elem in data.docs) {
        var song = SongModel.fromJson(elem.data());
        bool isFavorite = await sl<IsFavoriteSongUseCase>().call(
          params: elem.reference.id
        );
        song.isFavorite = isFavorite;
        song.songId = elem.reference.id;
        //Convierte el modelo a una entidad
        songs.add(song.toEntity());
      }
      return Right(songs);
    }catch(e){
      return left("An error occurred, Please try again. $e");
    }
  }

  @override
  Future<Either> getPlayList() async{
    try {
      List<SongEntity> songs = [];
      var data = await FirebaseFirestore.instance.collection("Songs")
          .orderBy("releaseDate", descending: true)
          .get();
      for (var elem in data.docs) {
        var song = SongModel.fromJson(elem.data());
        bool isFavorite = await sl<IsFavoriteSongUseCase>().call(
            params: elem.reference.id
        );
        song.isFavorite = isFavorite;
        song.songId = elem.reference.id;
        //Convierte el modelo a una entidad
        songs.add(song.toEntity());
      }
      return Right(songs);
    }catch(e){
      return left("An error occurred, Please try again. $e");
    }
  }

  @override
  Future<Either> addOrRemoveFavoriteSong(String songId) async {
    try {
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      late bool isFavorite;
      var user = firebaseAuth.currentUser;
      String uId = user!.uid;
      QuerySnapshot favoriteSongs = await firebaseFirestore.
      collection('Users').
      doc(uId).
      collection('Favorites').
      where("songId", isEqualTo: songId).
      get();

      if (favoriteSongs.docs.isNotEmpty) {
        //Delete song
        await favoriteSongs.docs.first.reference.delete();
        isFavorite = false;
      } else {
        await firebaseFirestore.
        collection("Users").
        doc(uId).
        collection("Favorites").
        add({
          "songId": songId,
          "addedDate": Timestamp.now()
        });
        isFavorite = true;
      }
      return Right(isFavorite);
    } catch(e){
      return const Left("An error occurred in favorites module");
    }
  }

  @override
  Future<bool> isFavorite(String songId) async{
    try {
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      var user = firebaseAuth.currentUser;
      String uId = user!.uid;
      QuerySnapshot favoriteSongs = await firebaseFirestore.
      collection('Users').
      doc(uId).
      collection('Favorites').
      where("songId", isEqualTo: songId).
      get();

      if (favoriteSongs.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch(e){
      return false;
    }
  }

  @override
  Future<Either> getUserFavoriteSongs() async{
    try {
      List<SongEntity> favoritesSongs = [];

      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      var user = firebaseAuth.currentUser;
      String uId = user!.uid;
      QuerySnapshot favoritesSnapshot = await firebaseFirestore.collection(
        "Users"
      ).doc(uId).collection("Favorites").get();

      for (var element in favoritesSnapshot.docs){
        String songId = element["songId"];
        var song = await firebaseFirestore.collection("Songs").doc(songId).get();
        SongModel songModel = SongModel.fromJson(song.data()!);
        songModel.isFavorite = true;
        songModel.songId = songId;
        favoritesSongs.add(
          songModel.toEntity()
        );
      }
      return Right(favoritesSongs);
    } catch(e){
      return left("An occurred error: $e");
    }
  }

}