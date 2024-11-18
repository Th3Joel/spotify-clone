import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/core/configs/assets/app_vectors.dart';
import 'package:spotify/presentation/intro/pages/get_started.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>{

  @override
  void initState(){
    super.initState();
    redirect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SvgPicture.asset(
              AppVectors.logo
          )
      ),
    );
  }

  //Para hacer metodo asyn/await

  Future<void> redirect () async{
    await Future.delayed(const Duration(seconds: 1));
    //Redirigir la pagina y reemplazarla en 1 segundos
    Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (BuildContext) =>const GetStarted())
    );
  }
}