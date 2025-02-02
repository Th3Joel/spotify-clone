import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/common/helpers/is_dark_mode.dart';
import 'package:spotify/common/widgets/appbar/app_bar.dart';
import 'package:spotify/core/configs/assets/app_images.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/presentation/home/widgets/news_songs.dart';
import 'package:spotify/presentation/home/widgets/play_list.dart';
import 'package:spotify/presentation/profile/pages/profile.dart';

import '../../../core/configs/assets/app_vectors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BasicAppBar(
          hideBack: true,
          actionBar: IconButton(
              onPressed:() {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (BuildContext context)=>const ProfilePage())
                );
              },
              icon: const Icon(Icons.person)
          ),
          title: SvgPicture.asset(
            AppVectors.logo,
            width: 40,
            height: 40,
          ),
        ),
        body: Column(
          children: [_homeTopCard(), _tabs(),_tabBarView()],
        ));
  }

  Widget _homeTopCard() {
    return Center(
      child: SizedBox(
          height: 144,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: SvgPicture.asset(AppVectors.homeTopCard,width: 370,),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 70),
                  child: Image.asset(AppImages.homeArtist),
                ),
              )
            ],
          )),
    );
  }

  Widget _tabs() {
    return TabBar(
      controller: _tabController,
      isScrollable: true,
      padding: const EdgeInsets.only(top: 20),
      indicatorColor: AppColors.primary,
      labelColor: context.isDarkMode ? Colors.white : Colors.black,
      tabAlignment: TabAlignment.center,
      dividerHeight: 0,
      tabs: const [
        Text(
          "News",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        Text("Videos",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
        Text("Artist",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
        Text("Podcast",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
      ],
    );
  }

  Widget _tabBarView(){
    return Expanded(
      child: TabBarView(
        controller: _tabController,
        children: const [
          Column(
              children: [
                NewsSongs(),
                PlayList()
              ]
          ),
          Center(child: Text('Contenido de Videos')),
          Center(child: Text('Contenido de Artist')),
          Center(child: Text('Contenido de Podcast')),
        ],
      ),
    );
  }
}
