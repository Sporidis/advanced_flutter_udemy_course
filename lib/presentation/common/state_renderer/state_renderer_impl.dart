import 'package:advanced_course_udemy/data/mapper/mapper.dart';
import 'package:advanced_course_udemy/presentation/common/state_renderer/state_renderer.dart';
import 'package:advanced_course_udemy/presentation/resources/string_manager.dart';
import 'package:flutter/material.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();
  String getMessage();
}

// Loading state (POPUP or FULL SCREEN)
class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  LoadingState({required this.stateRendererType, String? message})
      : message = message ?? AppStrings.loading;

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

// Error state (POPUP or FULL SCREEN)
class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  ErrorState(this.stateRendererType, this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

// Content state (FULL SCREEN)
class ContentState extends FlowState {
  ContentState();

  @override
  String getMessage() => EMPTY;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.CONTENT_SCREEN_STATE;
}

// Empty state (FULL SCREEN)
class EmptyState extends FlowState {
  String message;

  EmptyState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.EMPTY_SCREEN_STATE;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget,
      Function retryActionFunction) {
    switch (runtimeType) {
      case LoadingState _:
        {
          if (getStateRendererType() == StateRendererType.POPUP_LOADING_STATE) {
            //showing popup dialog
            showPopUp(context, getStateRendererType(), getMessage());

            // return the content ui of the screen
            return contentScreenWidget;
          } else {
            //StateRendererType.FULL_SCREEN_LOADING_STATE
            return StateRenderer(
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              retryActionFunction: retryActionFunction,
            );
          }
        }
      case ErrorState:
        {
          dismissDialog(context);
          if (getStateRendererType() == StateRendererType.POPUP_SCREEN_ERROR_STATE) {
            //showing popup dialog
            showPopUp(context, getStateRendererType(), getMessage());

            // return the content ui of the screen
            return contentScreenWidget;
          } else {
            //StateRendererType.FULL_SCREEN_ERROR_STATE
            return StateRenderer(
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              retryActionFunction: retryActionFunction,
            );
          }
        }
      case ContentState:
        {
          dismissDialog(context); 
          return contentScreenWidget;
        }
      case EmptyState:
        {
          dismissDialog(context);
          return StateRenderer(
            stateRendererType: getStateRendererType(),
            message: getMessage(),
            retryActionFunction: retryActionFunction,
          );
        }
      default:
        {
          return contentScreenWidget;
        }
    }
  }
  
  dismissDialog(BuildContext context) {
    if(_isThereCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  _isThereCurrentDialogShowing(BuildContext context) => 
      ModalRoute.of(context)?.isCurrent != true;

  showPopUp(BuildContext context, StateRendererType stateRendererType,
      String message) {
    // show dialog
    WidgetsBinding.instance.addPostFrameCallback((_) => showDialog(
          context: context,
          builder: (BuildContext context) => StateRenderer(
            stateRendererType: stateRendererType,
            message: message,
            retryActionFunction: () {},
          ),
        ));
  }
}
