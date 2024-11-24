import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/common/widgets/appbar/app_bar.dart';
import 'package:spotify/domain/entities/song/song.dart';
import 'package:spotify/presentation/song_player/bloc/song_player_cubit.dart';
import 'package:spotify/presentation/song_player/bloc/song_player_state.dart';

import '../../../core/configs/constants/app_urls.dart';
import '../../../core/configs/theme/app_colors.dart';

class SongPlayerPage extends StatelessWidget {
  final SongEntity songEntity;
  const SongPlayerPage({super.key, required this.songEntity});

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: BasicAppBar(
        actionBar: IconButton(
            onPressed: () {}, icon: const Icon(Icons.more_vert_rounded)),
        title: const Text(
          "Now Playing",
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            children: [
              _songCover(ctx),
              const SizedBox(
                height: 20,
              ),
              _songDetail(ctx),
              const SizedBox(
                height: 20,
              ),
              _songPlayer()
            ],
          )),
    );
  }

  Widget _songCover(BuildContext ctx) {
    return Container(
      height: MediaQuery.of(ctx).size.height / 2,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                  '${AppUrls.coverFirestorage}${songEntity.artist} - ${songEntity.title}.jpg?${AppUrls.mediaAlt}'))),
    );
  }

  Widget _songDetail(BuildContext ctx) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            songEntity.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            songEntity.artist,
            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
          ),
        ],
      ),
      IconButton(
          onPressed: () {

          },
          icon: Icon(
            Icons.favorite_rounded,
            size: 35,
            color: ctx.isDarkMode ? AppColors.darkGrey : Colors.white,
          ))
    ]);
  }

  Widget _songPlayer(){
    return BlocProvider(
      create: (_)=>SongPlayerCubit()..loadSong(
          '${AppUrls.songFirestorage}${songEntity.artist} - ${songEntity.title}.mp3?${AppUrls.mediaAlt}'
      ),
      child: BlocBuilder<SongPlayerCubit,SongPlayerState>(
        builder: (ctx,state){
          if(state is SongPlayerLoading){
            return const CircularProgressIndicator();
          }
          if(state is SongPlayerLoaded){
            return Column(
              children: [
                Slider(
                  value: ctx.read<SongPlayerCubit>().songPosition.inSeconds.toDouble(),
                  min: 0.0,
                  max: ctx.read<SongPlayerCubit>().songDuration.inSeconds.toDouble(),
                  onChanged:(value){

                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formatDuration(
                          ctx.read<SongPlayerCubit>().songPosition
                      )
                    ),
                    Text(
                        formatDuration(
                            ctx.read<SongPlayerCubit>().songDuration
                        )
                    )
                  ],
                ),
                const SizedBox(height: 20,),
                GestureDetector(
                  onTap: (){
                    ctx.read<SongPlayerCubit>().playOrPlayerSong();
                  },
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary
                    ),
                    child:Icon(
                        ctx.read<SongPlayerCubit>().audioPlayer.playing ? Icons.pause : Icons.play_arrow_rounded
                    ),
                  ),
                )
              ],
            );
          }
          return Container();
        },
      )
    );
  }

  String formatDuration(Duration duration){
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    return "${minutes.toString().padLeft(2,'0')}:${seconds.toString().padLeft(2,'0')}";
  }
}
