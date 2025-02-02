import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/data/models/auth/signin_user_req.dart';
import 'package:spotify/domain/repository/auth/auth_repository.dart';

import '../../../service_locator.dart';

//Devuelve un error
class GetUserUseCase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<AuthRepository>().getUser();
  }
}
