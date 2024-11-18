import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/main.dart';
import 'package:spotify/presentation/auth/pages/signup_or_sigin.dart';
import 'package:spotify/presentation/choose_mode/bloc/theme_cubit.dart';

import '../../../common/widgets/button/basic_app_button.dart';
import '../../../core/configs/assets/app_images.dart';
import '../../../core/configs/assets/app_vectors.dart';
import '../../../core/configs/theme/app_colors.dart';

class ChooseModePage extends StatelessWidget {
  const ChooseModePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [

        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  AppImages.chooseModeBG,
                ) ,
                fit: BoxFit.cover //Para que ocupe toda la pantalla
            ),
          ),
        ),
        Container(
          color: Colors.black.withOpacity(0.15),
        ),
        Padding(
          padding:const EdgeInsets.symmetric(
            vertical: 40,
            horizontal: 40,
          ),
          child:Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child:SvgPicture.asset(AppVectors.logo) ,
              )
              ,
              const Spacer(),
              const Text("Choose Mode",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: (){
                          context.read<ThemeCubit>().updateTheme(ThemeMode.dark);
                        },
                        child: ClipOval( //Para aplicar solo al componente el blur
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
                            child:  Container(
                              width: 80,
                              height:80,
                              decoration:  BoxDecoration(
                                  color: const Color(0xff30393C).withOpacity(0.5),
                                  shape: BoxShape.circle
                              ),
                              child: SvgPicture.asset(AppVectors.moon,fit: BoxFit.none,),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                       const Text("Dark Mode",
                        style: TextStyle(
                          color: AppColors.grey,
                          fontSize: 17,
                          fontWeight: FontWeight.w500
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    width:40 ,
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: (){
                          context.read<ThemeCubit>().updateTheme(ThemeMode.light);
                        },
                        child:ClipOval(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
                            child:  Container(
                              width: 80,
                              height:80,
                              decoration:  BoxDecoration(
                                  color: const Color(0xff30393C).withOpacity(0.5),
                                  shape: BoxShape.circle
                              ),
                              child: SvgPicture.asset(AppVectors.sun,fit: BoxFit.none,),
                            ),
                          ),
                        ) ,
                      )
                      ,
                      const SizedBox(height: 15),
                      const Text("Light Mode",
                        style: TextStyle(
                            color: AppColors.grey,
                            fontSize: 17,
                            fontWeight: FontWeight.w500
                        ),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(height: 50,),
              BasicAppButton(
                  height: 65,
                  title: "Continue",
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => const SignupOrSiginPage()
                        )
                    );
                  }
              )
            ],

          ),
        ),

      ]
      ),
    );
  }
}
