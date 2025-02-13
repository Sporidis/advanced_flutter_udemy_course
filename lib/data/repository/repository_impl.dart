import 'package:advanced_course_udemy/data/data_source/remote_data_source.dart';
import 'package:advanced_course_udemy/data/mapper/mapper.dart';
import 'package:advanced_course_udemy/data/network/error_handler.dart';
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
      try {
        final response = await _remoteDataSource.login(request);
        if (response.status == ApiInternalStatus.success) {
          return Right(response.toDomain());
        } else {
          return Left(
            Failure(response.status ?? ApiInternalStatus.failure,
                response.message ?? ResponseMessage.defaultError),
          );
        }
      } catch (e) {
        return (Left(ErrorHandler.handle(e).failure));
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }
}
