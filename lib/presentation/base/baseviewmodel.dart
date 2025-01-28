abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOutputs {
  // shared variables and methods that are used in all viewmodels
}

abstract class BaseViewModelInputs {
  void start(); // will be called while init. of view model
  void dispose(); // will be called when view model dies
}

mixin class BaseViewModelOutputs {}
