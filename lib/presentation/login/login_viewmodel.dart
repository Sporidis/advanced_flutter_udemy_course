import 'dart:async';

import 'package:advanced_course_udemy/domain/usecase/login_usecase.dart';
import 'package:advanced_course_udemy/presentation/base/baseviewmodel.dart';
import 'package:advanced_course_udemy/presentation/common/freezed_data_classes.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();

  var loginObject = LoginObject("", "");
  final LoginUseCase? _loginUseCase; // TODO remove nullable
  LoginViewModel(this._loginUseCase);

  @override
  void dispose() {
    _userNameStreamController.close();
    _passwordStreamController.close();
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  login() async {
    (await _loginUseCase.execute(
            LoginUsecaseInput(loginObject.userName, loginObject.password)))
        .fold(
            (failure) => {
                  //handle error
                  print(failure.message)
                },
            (data) => {
                  //handle success
                  print(data.customer?.name)
                });
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(
        password: password); // data class operation same as kotlin
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    loginObject = loginObject.copyWith(
        userName: userName); // data class operation same as kotlin
  }

  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outputIsUserNameValid => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  //private functions
  bool _isPasswordValid(String password) {
    return password.length > 6;
  }

  bool _isUserNameValid(String userName) {
    return userName.length > 6;
  }
}

mixin LoginViewModelInputs {
  //3 functions
  setUserName(String userName);
  setPassword(String password);
  login();

  //2 sinks for input streams
  Sink get inputUserName;
  Sink get inputPassword;
}

mixin LoginViewModelOutputs {
  //2 streams
  Stream<bool> get outputIsUserNameValid;
  Stream<bool> get outputIsPasswordValid;
}
