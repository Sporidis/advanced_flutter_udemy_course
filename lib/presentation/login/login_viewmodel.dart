import 'package:advanced_course_udemy/presentation/base/baseviewmodel.dart';

class LoginViewmodel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  // TODO: implement inputPassword
  Sink get inputPassword => throw UnimplementedError();

  @override
  // TODO: implement inputUserName
  Sink get inputUserName => throw UnimplementedError();

  @override
  login() {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  setPassword(String password) {
    // TODO: implement setPassword
    throw UnimplementedError();
  }

  @override
  setUserName(String userName) {
    // TODO: implement setUserName
    throw UnimplementedError();
  }

  @override
  // TODO: implement outputIsPasswordValid
  Stream<bool> get outputIsPasswordValid => throw UnimplementedError();

  @override
  // TODO: implement outputIsUserNameValid
  Stream<bool> get outputIsUserNameValid => throw UnimplementedError();
}

abstract class LoginViewModelInputs {
  //3 functions
  setUserName(String userName);
  setPassword(String password);
  login();

  //2 sinks for input streams
  Sink get inputUserName;
  Sink get inputPassword;
}

abstract class LoginViewModelOutputs {
  //2 streams
  Stream<bool> get outputIsUserNameValid;
  Stream<bool> get outputIsPasswordValid;
}
