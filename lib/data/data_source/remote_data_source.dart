import 'package:advanced_course_udemy/data/network/app_api.dart';
import 'package:advanced_course_udemy/data/request/request.dart';
import 'package:advanced_course_udemy/data/responses/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest request);
}

class RemoteDataSourceImpl extends RemoteDataSource {
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImpl(this._appServiceClient);
  @override
  Future<AuthenticationResponse> login(LoginRequest request) async {
    return await _appServiceClient.login(
      request.email,
      request.password,
      request.imei,
      request.deviceType,
    );
  }
}
