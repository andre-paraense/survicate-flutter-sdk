import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:survicate_flutter_sdk/models/survicate_answer_model.dart';
import 'package:survicate_flutter_sdk/models/user_traits_model.dart';

/// Client for accessing Survicate SDK.
class SurvicateFlutterSdk {
  /// listener triggered when survey gets loaded and appears in user’s interface.
  Function(String) onSurveyDisplayedListener;
  /// listener triggered after a response submitted to each question.
  Function(String, num, SurvicateAnswerModel) onQuestionAnsweredListener;
  /// listener triggered after user closes the survey using the close button.
  Function(String) onSurveyClosedListener;
  /// triggered when user responds to their last question and therefore finishes a survey.
  Function(String) onSurveyCompletedListener;

  static const MethodChannel _channel =
      const MethodChannel('survicate_flutter_sdk');

  /// Constructor for the Client for accessing Survicate SDK.
  SurvicateFlutterSdk() {
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

  /// Registers Survey activity listeners
  ///
  /// [callbackSurveyDisplayedListener] the listener to be called when a survey gets loaded and appears in user’s interface.
  /// [callbackQuestionAnsweredListener] the listener to be called after a response submitted to each question.
  /// [callbackSurveyClosedListener] the listener to be called after user closes the survey using the close button.
  /// [callbackSurveyCompletedListener] the listener to be called when user responds to their last question and therefore finishes a survey.
  Future<bool> registerSurveyListeners({
      Function(String surveyId) callbackSurveyDisplayedListener,
      Function(String surveyId, num questionId, SurvicateAnswerModel answer) callbackQuestionAnsweredListener,
      Function(String surveyId) callbackSurveyClosedListener,
      Function(String surveyId) callbackSurveyCompletedListener
  }) async {
    if (callbackSurveyDisplayedListener == null || callbackQuestionAnsweredListener == null || callbackSurveyClosedListener == null || callbackSurveyCompletedListener == null) {
      return false;
    }

    if (onSurveyDisplayedListener != null || onQuestionAnsweredListener != null || onSurveyClosedListener != null || onSurveyCompletedListener != null) {
      onSurveyDisplayedListener = callbackSurveyDisplayedListener;
      onQuestionAnsweredListener = callbackQuestionAnsweredListener;
      onSurveyClosedListener = callbackSurveyClosedListener;
      onSurveyCompletedListener = callbackSurveyCompletedListener;
      return true;
    }

    onSurveyDisplayedListener = callbackSurveyDisplayedListener;
    onQuestionAnsweredListener = callbackQuestionAnsweredListener;
    onSurveyClosedListener = callbackSurveyClosedListener;
    onSurveyCompletedListener = callbackSurveyCompletedListener;
    return await _channel.invokeMethod('registerSurveyListeners');
  }

  /// Unregisters Survey activity listeners
  ///
  Future<bool> unregisterSurveyListeners() async {

    if (onSurveyDisplayedListener == null && onQuestionAnsweredListener == null && onSurveyClosedListener == null && onSurveyCompletedListener == null) {
      return false;
    }

    onSurveyDisplayedListener = null;
    onQuestionAnsweredListener = null;
    onSurveyClosedListener = null;
    onSurveyCompletedListener = null;
    return await _channel.invokeMethod('unregisterSurveyListeners');
  }

  /// You can log custom user events throughout your application.
  /// They can later be used in Survicate panel to trigger your surveys.
  /// Events trigger surveys instantly after occurring in your app.
  ///
  /// [eventName] the name of the event to be logged
  Future<bool> invokeEvent(String eventName) async {
    if(eventName == null || eventName.isEmpty){
      return false;
    }

    return await _channel.invokeMethod('invokeEvent', <String, dynamic>{
      'eventName': eventName,
    });
  }

  /// A survey can appear when your application user is viewing a specific screen.
  /// As an example, a survey can be triggered to show up on the home screen of the application,
  /// after a user spends there more than 10 seconds.
  /// To achieve such effect, you need to send information to Survicate about user entering a screen.
  ///
  /// [screenName] the name of the screen the user is entering.
  Future<bool> enterScreen(String screenName) async {
    if(screenName == null || screenName.isEmpty){
      return false;
    }

    return await _channel.invokeMethod('enterScreen', <String, dynamic>{
      'screenName': screenName,
    });
  }

  /// A survey can appear when your application user is viewing a specific screen.
  /// As an example, a survey can be triggered to show up on the home screen of the application,
  /// after a user spends there more than 10 seconds.
  /// To achieve such effect, you need to send information to Survicate about user leaving a screen.
  ///
  /// [screenName] the name of the screen the user is leaving.
  Future<bool> leaveScreen(String screenName) async {
    if(screenName == null || screenName.isEmpty){
      return false;
    }

    return await _channel.invokeMethod('leaveScreen', <String, dynamic>{
      'screenName': screenName,
    });
  }

  /// You can assign custom attributes to your users.
  /// Those attributes can later be used to trigger the survey or even filter the survey results within Survicate panel.
  /// Please keep in mind that user traits are cached, you only have to provide them once, e.g. when user logs in, not after each initialize().
  /// You can also change their values at any time (which may potentially trigger showing the survey).
  ///
  /// [userTraits] the  custom attributes to be assigned to your users.
  Future<bool> setUserTraits(UserTraitsModel userTraits) async {
    if(userTraits == null || userTraits.toMap().isEmpty){
      return false;
    }

    return await _channel.invokeMethod('setUserTraits', userTraits.toMap());

  }

  /// This method will reset all user data stored on your device (views, traits, answers).
  /// If you need to test surveys on your device, this method might be helpful.
  Future<bool> reset() async {
    return await _channel.invokeMethod('reset');
  }
}
