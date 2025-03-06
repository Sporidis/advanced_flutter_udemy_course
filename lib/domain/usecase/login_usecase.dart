import 'package:advanced_course_udemy/data/network/failure.dart';
import 'package:advanced_course_udemy/data/request/request.dart';
import 'package:advanced_course_udemy/domain/model/model.dart';
import 'package:advanced_course_udemy/domain/repository/repository.dart';
import 'package:advanced_course_udemy/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

class LoginUsecase implements BaseUseCase<LoginUsecaseInput, Authentication> {
  Repository _repository;
  LoginUsecase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(LoginUsecaseInput input) async{
    await _repository.login(LoginRequest(input.email, input.password, "imei", "deviceType"));
  }
}

class LoginUsecaseInput {
  final String email;
  final String password;

  LoginUsecaseInput(this.email, this.password);
}
