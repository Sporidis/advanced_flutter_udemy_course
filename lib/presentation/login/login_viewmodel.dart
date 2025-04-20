import 'dart:async';

import 'package:advanced_course_udemy/domain/usecase/login_usecase.dart';
import 'package:advanced_course_udemy/presentation/base/baseviewmodel.dart';
import 'package:advanced_course_udemy/presentation/common/freezed_data_classes.dart';
import 'package:advanced_course_udemy/presentation/common/state_renderer/state_renderer_impl.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController _isAllInputsValidStreamController =
      StreamController<void>.broadcast();

  var loginObject = LoginObject("", "");
  final LoginUseCase _loginUseCase;
  LoginViewModel(this._loginUseCase);

  @override
  void dispose() {
    _userNameStreamController.close();
    _passwordStreamController.close();
    _isAllInputsValidStreamController.close();
  }

  @override
  void start() {
    // view tells state renderer, pls show content of the screen
    inputState.add(ContentState());
  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Sink get inputIsAllInputsValid => _isAllInputsValidStreamController.sink;

  @override
  login() async {
    (await _loginUseCase.execute(
            LoginUsecaseInput(loginObject.userName, loginObject.password)))
        .fold(
            (failure) => {
                  // handle failure
                },
            (data) => {
                  print(data.customer?.name),
                });
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(
        password: password); // data class operation same as kotlin

    _validate();
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    loginObject = loginObject.copyWith(
        userName: userName); // data class operation same as kotlin

    _validate();
  }

  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outputIsUserNameValid => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  @override
  Stream<bool> get outputIsAllInputsValid =>
      _isAllInputsValidStreamController.stream
          .map((event) => _isAllInputsValid());

  //private functions
  _validate() {
    inputIsAllInputsValid.add(null);
  }

  bool _isPasswordValid(String password) {
    return password.length > 6;
  }

  bool _isUserNameValid(String userName) {
    return userName.length > 6;
  }

  bool _isAllInputsValid() {
    return _isPasswordValid(loginObject.password) &&
        _isUserNameValid(loginObject.userName);
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

  Sink get inputIsAllInputsValid;
}

mixin LoginViewModelOutputs {
  //2 streams
  Stream<bool> get outputIsUserNameValid;
  Stream<bool> get outputIsPasswordValid;

  Stream<bool> get outputIsAllInputsValid;
}
