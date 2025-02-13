import 'package:advanced_course_udemy/data/data_source/remote_data_source.dart';
import 'package:advanced_course_udemy/data/mapper/mapper.dart';
import 'package:advanced_course_udemy/data/network/failure.dart';
import 'package:advanced_course_udemy/data/network/network_info.dart';
import 'package:advanced_course_udemy/data/request/request.dart';
import 'package:advanced_course_udemy/domain/model.dart';
import 'package:advanced_course_udemy/domain/repository.dart';
import 'package:dartz/dartz.dart';

class RepositoryImpl extends Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(this._remoteDataSource, this._networkInfo);
  @override
  Future<Either<Failure, Authentication>> login(LoginRequest request) async {
    if (await _networkInfo.isConnected) {
      final response = await _remoteDataSource.login(request);
      if (response.status == 0) {
        return Right(response.toDomain());
      } else {
        return Left(
          Failure(409, response.message ?? 'Biz error logic from API side'),
        );
      }
    } else {
      return Left(Failure(501, 'No internet connection'));
    }
  }
}
