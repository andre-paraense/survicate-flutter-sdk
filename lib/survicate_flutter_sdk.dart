import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:survicate_flutter_sdk/models/survicate_answer_model.dart';
import 'package:survicate_flutter_sdk/models/user_traits_model.dart';

/// Client for accessing Survicate SDK.
class SurvicateFlutterSdk {
  Function(String) onSurveyDisplayedListener;
  Function(String, num, SurvicateAnswerModel) onQuestionAnsweredListener;
  Function(String) onSurveyClosedListener;
  Function(String) onSurveyCompletedListener;

  static const MethodChannel _channel =
      const MethodChannel('survicate_flutter_sdk');

  /// Constructor for the Client for accessing Survicate SDK.
  ///
  /// [onSurveyDisplayedListener] (optional) listener triggered when survey gets loaded and appears in user’s interface.
  /// [onQuestionAnsweredListener] (optional) listener triggered after a response submitted to each question.
  /// [onSurveyClosedListener] (optional) listener triggered after user closes the survey using the close button.
  /// [onSurveyCompletedListener] (optional) listener triggered when user responds to their last question and therefore finishes a survey.
  SurvicateFlutterSdk({this.onSurveyDisplayedListener, this.onQuestionAnsweredListener, this.onSurveyClosedListener, this.onSurveyCompletedListener}) {
    _channel.setMethodCallHandler(handlerMethodCalls);
  }

  @visibleForTesting
  Future<dynamic> handlerMethodCalls(MethodCall call) async {
    switch (call.method) {
      case 'onSurveyDisplayedListener':
        if (onSurveyDisplayedListener == null) {
          return false;
        }

        if (call.arguments == null) {
          return false;
        }

        if (!call.arguments.containsKey('surveyId')) {
          return false;
        }

        String surveyId = call.arguments['surveyId'];

        onSurveyDisplayedListener(surveyId);
        return true;

      case 'onQuestionAnsweredListener':
        if (onQuestionAnsweredListener == null) {
          return false;
        }

        if (call.arguments == null) {
          return false;
        }

        if (!call.arguments.containsKey('surveyId') || !call.arguments.containsKey('questionId') || !call.arguments.containsKey('answer')) {
          return false;
        }

        String surveyId = call.arguments['surveyId'];
        num questionId = call.arguments['questionId'];
        SurvicateAnswerModel answer = SurvicateAnswerModel.fromMap(call.arguments['answer']);

        onQuestionAnsweredListener(surveyId, questionId, answer);
        return true;

      case 'onSurveyClosedListener':
        if (onSurveyClosedListener == null) {
          return false;
        }

        if (call.arguments == null) {
          return false;
        }

        if (!call.arguments.containsKey('surveyId')) {
          return false;
        }

        String surveyId = call.arguments['surveyId'];

        onSurveyClosedListener(surveyId);
        return true;

      case 'onSurveyCompletedListener':
        if (onSurveyCompletedListener == null) {
          return false;
        }

        if (call.arguments == null) {
          return false;
        }

        if (!call.arguments.containsKey('surveyId')) {
          return false;
        }

        String surveyId = call.arguments['surveyId'];

        onSurveyCompletedListener(surveyId);
        return true;

      default:
        throw MissingPluginException();
    }
  }

  /// Registers a callback to be called when a survey gets loaded and appears in user’s interface.
  ///
  /// [callback] the listener to attach
  Future<bool> registerSurveyDisplayedListener(Function(String surveyId) callback) async {
    if (callback == null) {
      return false;
    }

    if (onSurveyDisplayedListener != null) {
      onSurveyDisplayedListener = callback;
      return true;
    }

    onSurveyDisplayedListener = callback;
    return await _channel.invokeMethod('registerSurveyDisplayedListener');
  }

  /// Unregisters a callback so it will no longer be called when a survey gets loaded and appears in user’s interface.
  ///
  Future<bool> unregisterSurveyDisplayedListener() async {

    if (onSurveyDisplayedListener == null) {
      return false;
    }

    onSurveyDisplayedListener = null;
    return await _channel.invokeMethod('unregisterSurveyDisplayedListener');
  }

  /// Registers a callback to be called after a response submitted to each question.
  ///
  /// [callback] the listener to attach
  Future<bool> registerQuestionAnsweredListener(Function(String surveyId, num questionId, SurvicateAnswerModel answer) callback) async {
    if (callback == null) {
      return false;
    }

    if (onQuestionAnsweredListener != null) {
      onQuestionAnsweredListener = callback;
      return true;
    }

    onQuestionAnsweredListener = callback;
    return await _channel.invokeMethod('registerQuestionAnsweredListener');
  }

  /// Unregisters a callback so it will no longer be called after a response submitted to each question.
  ///
  Future<bool> unregisterQuestionAnsweredListener() async {

    if (onQuestionAnsweredListener == null) {
      return false;
    }

    onQuestionAnsweredListener = null;
    return await _channel.invokeMethod('unregisterQuestionAnsweredListener');
  }

  /// Registers a callback to be called after user closes the survey using the close button.
  ///
  /// [callback] the listener to attach
  Future<bool> registerSurveyClosedListener(Function(String surveyId) callback) async {
    if (callback == null) {
      return false;
    }

    if (onSurveyClosedListener != null) {
      onSurveyClosedListener = callback;
      return true;
    }

    onSurveyClosedListener = callback;
    return await _channel.invokeMethod('registerSurveyClosedListener');
  }

  /// Unregisters a callback so it will no longer be called after user closes the survey using the close button.
  ///
  Future<bool> unregisterSurveyClosedListener() async {

    if (onSurveyClosedListener == null) {
      return false;
    }

    onSurveyClosedListener = null;
    return await _channel.invokeMethod('unregisterSurveyClosedListener');
  }

  /// Registers a callback to be called when user responds to their last question and therefore finishes a survey.
  ///
  /// [callback] the listener to attach
  Future<bool> registerSurveyCompletedListener(Function(String surveyId) callback) async {
    if (callback == null) {
      return false;
    }

    if (onSurveyCompletedListener != null) {
      onSurveyCompletedListener = callback;
      return true;
    }

    onSurveyCompletedListener = callback;
    return await _channel.invokeMethod('registerSurveyCompletedListener');
  }

  /// Unregisters a callback so it will no longer be called when user responds to their last question and therefore finishes a survey.
  ///
  Future<bool> unregisterSurveyCompletedListener() async {

    if (onSurveyCompletedListener == null) {
      return false;
    }

    onSurveyCompletedListener = null;
    return await _channel.invokeMethod('unregisterSurveyCompletedListener');
  }

  /// Initializes the SDK in your application
  Future<void> initialize() async {
    await _channel.invokeMethod('initialize');
  }

  /// You can log custom user events throughout your application.
  /// They can later be used in Survicate panel to trigger your surveys.
  /// Events trigger surveys instantly after occurring in your app.
  ///
  /// [eventName] the name of the event to be logged
  Future<void> invokeEvent(String eventName) async {
    if(eventName == null || eventName.isEmpty){
      return;
    }

    await _channel.invokeMethod('invokeEvent', <String, dynamic>{
      'eventName': eventName,
    });
  }

  /// A survey can appear when your application user is viewing a specific screen.
  /// As an example, a survey can be triggered to show up on the home screen of the application,
  /// after a user spends there more than 10 seconds.
  /// To achieve such effect, you need to send information to Survicate about user entering a screen.
  ///
  /// [screenName] the name of the screen the user is entering.
  Future<void> enterScreen(String screenName) async {
    if(screenName == null || screenName.isEmpty){
      return;
    }

    await _channel.invokeMethod('enterScreen', <String, dynamic>{
      'screenName': screenName,
    });
  }

  /// A survey can appear when your application user is viewing a specific screen.
  /// As an example, a survey can be triggered to show up on the home screen of the application,
  /// after a user spends there more than 10 seconds.
  /// To achieve such effect, you need to send information to Survicate about user leaving a screen.
  ///
  /// [screenName] the name of the screen the user is leaving.
  Future<void> leaveScreen(String screenName) async {
    if(screenName == null || screenName.isEmpty){
      return;
    }

    await _channel.invokeMethod('leaveScreen', <String, dynamic>{
      'screenName': screenName,
    });
  }

  /// You can assign custom attributes to your users.
  /// Those attributes can later be used to trigger the survey or even filter the survey results within Survicate panel.
  /// Please keep in mind that user traits are cached, you only have to provide them once, e.g. when user logs in, not after each initialize().
  /// You can also change their values at any time (which may potentially trigger showing the survey).
  ///
  /// [userTraits] the  custom attributes to be assigned to your users.
  Future<void> setUserTraits(UserTraitsModel userTraits) async {
    if(userTraits == null || userTraits.toMap().isEmpty){
      return;
    }

    await _channel.invokeMethod('setUserTraits', userTraits.toMap());

  }

  /// This method will reset all user data stored on your device (views, traits, answers).
  /// If you need to test surveys on your device, this method might be helpful.
  Future<void> reset() async {
    await _channel.invokeMethod('reset');
  }
}
