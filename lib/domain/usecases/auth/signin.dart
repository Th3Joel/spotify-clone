import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/data/models/auth/create_user_req.dart';
import 'package:spotify/data/models/auth/signin_user_req.dart';
import 'package:spotify/data/sources/auth/auth_firebase_service.dart';
import 'package:spotify/domain/repository/auth/auth_repository.dart';

import '../../../service_locator.dart';

//Devuelve un error
class SigninUseCase implements UseCase<Either,SigninUserReq>{
  @override
  Future<Either> call({SigninUserReq ? params}) {
    return sl<AuthRepository>().Signin(params!);
  }

}