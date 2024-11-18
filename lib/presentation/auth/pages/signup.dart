import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/common/widgets/appbar/app_bar.dart';
import 'package:spotify/common/widgets/button/basic_app_button.dart';
import 'package:spotify/core/configs/assets/app_vectors.dart';
import 'package:spotify/data/models/auth/create_user_req.dart';
import 'package:spotify/domain/usecases/auth/signup.dart';
import 'package:spotify/presentation/home/pages/home.dart';

import '../../../service_locator.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  TextEditingController _fullName = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: _siginText(),
        appBar: BasicAppBar(
          title: SvgPicture.asset(
            AppVectors.logo,
            height: 40,
            width: 40,
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
          child: Column(
            children: [
              _registerText(),
              const SizedBox(
                height: 50,
              ),
              _fullNameField(),
              const SizedBox(
                height: 20,
              ),
              _emailField(),
              const SizedBox(
                height: 20,
              ),
              _passwordField(),
              const SizedBox(
                height: 20,
              ),
              BasicAppButton(
                  height: 74,
                  title: "Create Account",
                  onPressed: () async {
                    var result = await sl<SignupUseCase>().call(
                        params: CreateUserReq(
                            fullName: _fullName.text.toString(),
                            email: _email.text.toString(),
                            password: _password.text.toString()));
                    //Left es que falla y right que es exitosa
                    result.fold((l) {
                      var snackbar = SnackBar(content: Text(l));
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    }, (r) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext ctx) => const HomePage()),
                          (route) => false);
                    });
                  })
            ],
          ),
        ));
  }

  Widget _registerText() {
    return const Text(
      "Register",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
      textAlign: TextAlign.center,
    );
  }

  Widget _fullNameField() {
    return TextField(
      controller: _fullName,
      decoration: const InputDecoration(hintText: "Full Name"),
    );
  }

  Widget _emailField() {
    return TextField(
      controller: _email,
      decoration: const InputDecoration(hintText: "Enter Email"),
    );
  }

  Widget _passwordField() {
    return TextField(
      controller: _password,
      decoration: const InputDecoration(hintText: "Password"),
    );
  }

  Widget _siginText() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Do You Have A Account?",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
          TextButton(onPressed: () {}, child: const Text("Sign In"))
        ],
      ),
    );
  }
}
