import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/common/widgets/button/basic_app_button.dart';
import 'package:spotify/core/configs/assets/app_images.dart';
import 'package:spotify/core/configs/assets/app_vectors.dart';
import 'package:spotify/presentation/choose_mode/pages/choose_mode.dart';

import '../../../core/configs/theme/app_colors.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [

        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                AppImages.introBG,
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
              const Text("Enjoy Listening To Music",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 21),
              const Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut ex urna, lacinia eget hendrerit sit amet, semper eget arcu. Mauris tempor tellus ex, ut sollicitudin augue gravida molestie.",
                style: TextStyle(
                    color: AppColors.grey,
                    fontSize: 13,
                    fontWeight: FontWeight.w500
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20,),
              BasicAppButton(
                  height: 65,
                  title: "Get Started",
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => const ChooseModePage()
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
