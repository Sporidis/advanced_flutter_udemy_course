import 'dart:async';

import 'package:advanced_course_udemy/presentation/common/state_renderer/state_renderer_impl.dart';

abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOutputs {
  // shared variables and methods that are used in all viewmodels
  final StreamController _inputStateStreamController = StreamController<FlowState>.broadcast();

  @override
  Sink get inputState => _inputStateStreamController.sink;

  @override
  Stream<FlowState> get outputState => _inputStateStreamController.stream.map((flowState) => flowState);
  
  @override
  void dispose() {
    _inputStateStreamController.close();
  }
}

abstract class BaseViewModelInputs {
  void start(); // will be called while init. of view model
  void dispose(); // will be called when view model dies

  Sink get inputState; // to send data to stream

}

mixin BaseViewModelOutputs {
  Stream<FlowState> get outputState; // to receive data from stream
}
