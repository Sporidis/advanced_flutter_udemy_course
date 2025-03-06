import 'package:advanced_course_udemy/data/network/failure.dart';
import 'package:advanced_course_udemy/data/request/request.dart';
import 'package:advanced_course_udemy/domain/model/model.dart';
import 'package:dartz/dartz.dart';

abstract class Repository {
  Future<Either<Failure, Authentication>> login(LoginRequest request);
}
