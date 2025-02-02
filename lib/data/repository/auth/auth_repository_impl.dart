import 'package:dartz/dartz.dart';
import 'package:spotify/data/models/auth/create_user_req.dart';
import 'package:spotify/data/models/auth/signin_user_req.dart';
import 'package:spotify/data/sources/auth/auth_firebase_service.dart';
import 'package:spotify/domain/repository/auth/auth_repository.dart';

import '../../../service_locator.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either> Signin(SigninUserReq signinUserReq) async{
    return await sl<AuthFirebaseService>().signin(signinUserReq);

  }

  @override
  Future<Either> Signup(CreateUserReq createUserReq) async{
    return await sl<AuthFirebaseService>().signup(createUserReq);
  }

  @override
  Future<Either> getUser() async{
    return await sl<AuthFirebaseService>().getUser();
  }

}