import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/common/widgets/appbar/app_bar.dart';
import 'package:spotify/core/configs/constants/app_urls.dart';
import 'package:spotify/presentation/profile/bloc/favorite_songs_cubit.dart';
import 'package:spotify/presentation/profile/bloc/favorite_songs_state.dart';
import 'package:spotify/presentation/profile/bloc/profile_info_cubit.dart';
import 'package:spotify/presentation/profile/bloc/profile_info_state.dart';
import 'package:spotify/presentation/song_player/pages/song_player.dart';

import '../../../common/widgets/favorite_button/favorite_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppBar(
        title: Text("Profile"),
        backgroundColor: Color(0xff2c2b2b),
      ),
      body: Column(
        children: [_profileInfo(context), _favoriteSongs()],
      ),
    );
  }

  Widget _profileInfo(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileInfoCubit()..getUser(),
      child: Container(
        height: MediaQuery.of(context).size.height / 3.5,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: context.isDarkMode ? const Color(0xff2c2b2b) : Colors.white,
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(60),
                bottomRight: Radius.circular(60))),
        child: BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
          builder: (context, state) {
            if (state is ProfileInfoLoading) {
              return Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator());
            }
            if (state is ProfileInfoLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(state.userEntity.imageURL ??
                                AppUrls.defaultImage))),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    state.userEntity.email!,
                    style: const TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    state.userEntity.fullName!,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  )
                ],
              );
            }

            if (state is ProfileInfoFailure) {
              return const Text("Please try again");
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _favoriteSongs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          const Text("Favorites Songs", style: TextStyle(fontSize: 20)),
          const SizedBox(
            height: 10,
          ),
          BlocProvider(
            create: (ctx) => FavoriteSongsCubit()..getFavoriteSongs(),
            child: BlocBuilder<FavoriteSongsCubit, FavoriteSongsState>(
              builder: (ctx, state) {
                if (state is FavoriteSongsLoading) {
                  return const CircularProgressIndicator();
                }

                if (state is FavoriteSongsLoaded) {
                  return ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (ctx, i) =>
                          GestureDetector(
                            onTap: (){
                              Navigator.push(
                                ctx,
                                MaterialPageRoute(builder: (BuildContext ctx) => SongPlayerPage(songEntity: state.favoriteSongs[i]))
                              );
                            }
                            ,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                          height: 75,
                                          width: 75,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      '${AppUrls.coverFirestorage}${state.favoriteSongs[i].artist} - ${state.favoriteSongs[i].title}.jpg?${AppUrls.mediaAlt}')))),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            state.favoriteSongs[i].title,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            state.favoriteSongs[i].artist,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 11),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(state.favoriteSongs[i].duration
                                          .toString()
                                          .replaceAll(".", ":")),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      FavoriteButton(
                                          songEntity: state.favoriteSongs[i],
                                          key:UniqueKey(),
                                          function: (){
                                            ctx.read<FavoriteSongsCubit>().removeSong(i);
                                          },
                                      ),
                                    ],
                                  )
                                ]),
                          ),
                      separatorBuilder: (ctx, _) => const SizedBox(height: 20),
                      itemCount: state.favoriteSongs.length);
                }

                if (state is FavoriteSongsFailure) {
                  return const Text("Please try again");
                }

                return Container();
              },
            ),
          )
        ],
      ),
    );
  }
}
